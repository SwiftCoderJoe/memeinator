//
//  TransactionDetailView.swift
//  memeinator.new
//
//  Created by Kids on 12/31/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

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
                // FIXME: Goes nowhere
                Link("Contact Us", destination: URL(string: "https://SwiftCoderJoe.github.io")!)
                
                Button("Request a Refund", action: {
                    settingsViewModel.store.requestRefund(for: transaction, in: windowScene)
                })
            }
        }
    }
}
