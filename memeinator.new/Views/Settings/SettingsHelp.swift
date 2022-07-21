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
                Section("About") {
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

                Section("Support") {
                    Link("Frequently Asked Questions",
                         destination: URL(string: "https://memeinator.joecardenas.dev/faq")!)
                    Link("Privacy",
                         destination: URL(string: "https://memeinator.joecardenas.dev/privacy")!)
                    Link("Contact Us",
                         destination: URL(string: "https://memeinator.joecardenas.dev/contact")!)
                    Link("Feedback",
                         destination: URL(string: "https://memeinator.joecardenas.dev/contact")!)
                }
                
                Section("Troubleshooting") {
                    Button("Reset All Preferences", action: {
                        settingsViewModel.resetPreferences()
                    })
                    
                    Button("Crash App", action: {
                        fatalError("User manually triggered a crash. ")
                    })
                }
                
                Section("Purchases") {
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
