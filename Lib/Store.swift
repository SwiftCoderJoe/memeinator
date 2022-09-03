//
//  Store.swift
//
//  Created by Joe Cardenas on 11/12/21.
//

import Foundation
import StoreKit
import Combine

class Store: ObservableObject {
    typealias Transaction = StoreKit.Transaction
    
    @Published private(set) var pro: Bool = false {
        didSet {
            proUpdatesPublisher.send(pro)
        }
    }
    
    @Published private(set) var currentEntitlementTransactions: [MemeinatorTransaction] = []
    
    var updateListenerTask: Task<Void, Error>?
    
    var proUpdatesPublisher = PassthroughSubject<Bool, Never>()
    
    init() {
        Task {
            do {
                // This should maybe be done with currentEntitlements instead of isPurchased
                pro = try await isPurchased(.pro)
                
                try await updateTransactionsList()
            } catch {
                print("An Error occured while checking purchase states of IAP.")
                pro = false
            }
        }
        
        updateListenerTask = listenForTransactions()
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func isPurchased(_ productIdentifier: MemeinatorProduct) async throws -> Bool {
        guard let result = await Transaction.latest(for: productIdentifier.rawValue) else {
            return false
        }
        
        let transaction = try checkVerified(result)
        
        // We check for isUpgraded here, even though we don't currently use tiered products.
        return transaction.revocationDate == nil && !transaction.isUpgraded
    }
    
    @discardableResult
    func purchase(_ productID: MemeinatorProduct) async throws -> Transaction? {
        // Get the product object from StoreKit
        let product = try await Product.products(for: [productID.rawValue])[0]
        
        // Show the purchase window
        let result = try await product.purchase()
        
        // Check to see if the user followed through
        switch result {
        case .success(let verification):
            // Make sure the tx is verified
            let transaction = try checkVerified(verification)

            pro = true
            
            // Finished
            await transaction.finish()
            
            try await updateTransactionsList()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func restorePurchases() async throws {
        try await AppStore.sync()
    }
    
    func requestRefund(for transaction: MemeinatorTransaction, in windowScene: UIWindowScene) {
        Task {
            try await Transaction.beginRefundRequest(for: transaction.id, in: windowScene)
        }
    }
    
    func updateTransactionsList() async throws {
        var transactions: [MemeinatorTransaction] = []
        
        for await unverifiedTransaction in Transaction.currentEntitlements {
            let transaction = try checkVerified(unverifiedTransaction)
            
            transactions.append(
                MemeinatorTransaction(
                    product: MemeinatorProduct(rawValue: transaction.productID)!,
                    purchaseDate: transaction.purchaseDate,
                    id: transaction.id
                )
            )
        }
        
        currentEntitlementTransactions = transactions
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                print("recieved tx")
                do {
                    let transaction = try self.checkVerified(result)
                    
                    if transaction.revocationDate == nil {
                        // If the transaction is not revoked,
                        
                        print("recieved tx productid: \(transaction.productID)")
                        
                        switch transaction.productID {
                        case MemeinatorProduct.pro.rawValue:
                            self.pro = true
                        default:
                            break
                        }
                    } else {
                        print("recieved tx productid: \(transaction.productID)")
                        switch transaction.productID {
                        case MemeinatorProduct.pro.rawValue:
                            self.pro = false
                        default:
                            break
                        }
                    }
                    
                    await transaction.finish()
                    
                    try await self.updateTransactionsList()
                    
                } catch {
                    print("Transaction verification failed.")
                }
                
            }
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        // Check if the transaction passes StoreKit verification.
        switch result {
        case .unverified:
            // Verification failed
            throw StoreError.failedVerification
        case .verified(let safe):
            // Verification succeeded, return the unwrapped, safe transaction
            return safe
        }
    }
}

enum StoreError: Error {
    case failedVerification
}

enum MemeinatorProduct: String {
    case pro = "com.bb.memeinator.pro"
    
    var name: String {
        switch self {
        case .pro:
            return "Memeinator Pro"
        }
    }
    
    var icon: String {
        switch self {
        case .pro:
            return "star.fill"
        }
    }
}

struct MemeinatorTransaction: Identifiable {
    let product: MemeinatorProduct
    let purchaseDate: Date
    var formattedPurchaseDate: String {
        purchaseDate.formatted(date: .numeric, time: .shortened)
    }
    let id: UInt64
}
