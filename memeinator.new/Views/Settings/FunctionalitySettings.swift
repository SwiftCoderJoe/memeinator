//
//  FunctionalitySettings.swift
//
//  Created by Joe Cardenas on 12/30/21.
//

import Foundation
import FirebaseAnalytics
import SwiftUI

/// "Settings" page of the Memeinator More tab.
struct FunctionalitySettings: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var analyticsConsentManager: AnalyticsConsentManager
    
    var body: some View {
        Form {
            
            Section("Analytics") {
                VStack {
                    Toggle("Enable Google Analytics", isOn: $analyticsConsentManager.consentGiven)
                    Text("Google Analytics helps us understand how we can improve Memeinator. We understand that not everybody likes Google Analytics, so you can disable it if you'd like. You may need to restart the app to fully disable analytics.")
                        .font(.footnote)
                }
            }
            
            ProGroup(name: "Furryspeak") {
                Toggle("Separate Furryspeak and Stutter", isOn: $settingsViewModel.furryspeakStutterSeparated)
                VStack {
                    Stepper(value: $settingsViewModel.stutterProbability, in: 1...50, step: 1, label: {
                        Text("Chance of stutter: " +
                            (settingsViewModel.stutterProbability == 1 ?
                            "Always" :
                            "1 in \(settingsViewModel.stutterProbability)")
                        )
                    })
                }
                
            }
            
            ProGroup(name: "Repeat") {
                Stepper(value: $settingsViewModel.repeatsMax,
                        in: 2...200,
                        step: 1,
                        label: {
                            Text("Max Repeats: \(settingsViewModel.repeatsMax)")
                        })
                if settingsViewModel.repeatsMax > 25 {
                    Label("High repeat values may cause performance issues",
                          systemImage: "exclamationmark.triangle.fill")
                        .accentColor(.yellow)
                }
            }
            
            ProGroup(name: "Coming soon!", content: {
                Text("Zalgo (maxes)")
            })

        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FunctionalitySettings_Previews: PreviewProvider {
    static var previews: some View {
        FunctionalitySettings()
            .environmentObject(SettingsViewModel())
            .environmentObject(AnalyticsConsentManager())
    }
}
