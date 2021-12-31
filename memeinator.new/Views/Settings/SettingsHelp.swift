//
//  SettingsHelp.swift
//  memeinator.new
//
//  Created by Kids on 12/30/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingsHelp: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
    
    var body: some View {
        VStack {
            Form {
                Section(header:
                    Text("About")
                ) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(appVersion ?? "Unknown")
                    }
                    HStack {
                        Text("App Build Number")
                        Spacer()
                        Text(appBuild ?? "Unknown")
                    }
                    HStack {
                        Text("App Mode")
                        Spacer()
                        Text(settingsViewModel.store.pro ? "Pro" : "Standard")
                    }
                }
                // FIXME: Most of these links go nowhere
                Section(header:
                    Text("Support")
                ) {
                    Link("Frequently Asked Questions",
                         destination: URL(string: "https://swiftcoderjoe.github.io")!)
                    Link("Submit Feedback",
                         destination: URL(string: "https://swiftcoderjoe.github.io")!)
                    Link("Contact Us",
                         destination: URL(string: "mailto:coderjoe05@gmail.com")!)
                }
                
                Section(header:
                    Text("Purchases")
                ) {
                    if settingsViewModel.store.currentEntitlementTransactions.count == 0 {
                        Text("No Purchases Found")
                    } else {
                        transactions
                    }
                    
                        
                }
            }
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var transactions: some View {
        ForEach(settingsViewModel.store.currentEntitlementTransactions) { transaction in
            
            NavigationLink(
                destination: TransactionDetailView(for: transaction)
                    .environmentObject(settingsViewModel)
            ) {
                HStack {
                    Image(systemName: transaction.product.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.purple)
                    VStack(alignment: .leading) {
                        Text(transaction.product.name)
                            .font(.system(size: 25))
                        Text("Purchased: \(transaction.formattedPurchaseDate)")
                            .font(.system(size: 15, weight: .light))
                    }
                    .foregroundColor(.primary)
                }
            }
            
        }
    }
}
