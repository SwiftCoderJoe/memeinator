//
//  SettingsView.swift
//  SettingsView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
    
    var body: some View {
        VStack(spacing: 0.0) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            LargeDivider()
            
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
                }
                
                ProGroup(name: "Coming soon!", content: {
                    Text("Repeat (max)")
                    Text("Zalgo (maxes)")
                    Text("Separate Furryspeak and Stutter")
                })

            }
            
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
