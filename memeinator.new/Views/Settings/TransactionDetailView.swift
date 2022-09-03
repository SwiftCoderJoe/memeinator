//
//  TransactionDetailView.swift
//
//  Created by Joe Cardenas on 12/31/21.
//

import Foundation
import SwiftUI

/// A detail view that allows users to refund purchases. Used in the Help screen after tapping on a purchase.
struct TransactionDetailView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let transaction: MemeinatorTransaction
    
    // A force unwrap AND a force downcast... haven't seen that one before. Fix?
    let windowScene = UIApplication.shared.connectedScenes.first! as! UIWindowScene
    
    init(for transaction: MemeinatorTransaction) {
        self.transaction = transaction
    }
    
    var body: some View {
        Form {
            Section("About") {
                HStack {
                    Text("Product Name:")
                    Spacer()
                    Text(transaction.product.name)
                }
                HStack {
                    Text("Purchase Date:")
                    Spacer()
                    Text(transaction.formattedPurchaseDate)
                }
                HStack {
                    Text("Transaction ID:")
                    Spacer()
                    Text(String(transaction.id))
                }
            }
            
            Section("Actions") {
                Link("Contact Us", destination: URL(string: "https://memeinator.joecardenas.dev/contact")!)
                
                Button("Request a Refund", action: {
                    settingsViewModel.store.requestRefund(for: transaction, in: windowScene)
                })
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(for: MemeinatorTransaction(
            product: .pro,
            purchaseDate: Date.now,
            id: 1001
        ))
            .environmentObject(SettingsViewModel())
    }
}
