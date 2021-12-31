//
//  FunctionalitySettings.swift
//  memeinator.new
//
//  Created by Kids on 12/30/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct FunctionalitySettings: View {
    // FIXME: Settings changed with Pro do not get reset when Pro is revoked
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Form {
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
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}
