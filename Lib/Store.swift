//
//  Store.swift
//  memeinator.new
//
//  Created by Kids on 11/12/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import StoreKit

class Store: ObservableObject {
    typealias Transaction = StoreKit.Transaction
    
    @Published private(set) var pro: Bool = false
    
    var updateListenerTask: Task<Void, Error>?
    
    init() {
        // In theory we should do this, but because the only IAP we have is checked every time we use it, it shouldn't matter.
        Task {
            do {
                pro = try await isPurchased(.pro)
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

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    
    func listenForTransactions() -> Task<Void, Error> {
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
                } catch {
                    print("Transaction verification failed.")
                }
                
            }
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
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
}
