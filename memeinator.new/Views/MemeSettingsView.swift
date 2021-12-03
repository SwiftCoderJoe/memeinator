//
//  MemeSettingsView.swift
//  MemeSettingsView
//
//  Created by Kids on 9/2/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct MemeSettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @State var dummySwitch: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 5.0) {
            
            Text(settingsViewModel.createFormattedString())
                .font(.system(size: 25))
                .lineLimit(nil)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .padding()
                // .roundedBackground(color: Color(uiColor: colorScheme == .dark ? .systemBackground : .systemGroupedBackground))
                .roundedBackground(color: Color(uiColor: .systemGroupedBackground))
                .padding(.horizontal)
            
            
            CopyPasteRegen().environmentObject(settingsViewModel)
            
            
            Form {
                
                Feature("Spaces", isExpanded: $settingsViewModel.spacingEnabled) {
                    Stepper("Amount: \(settingsViewModel.numberOfSpaces)",
                            value: $settingsViewModel.numberOfSpaces,
                            in: settingsViewModel.spacesRange,
                            step: settingsViewModel.spacesStep)
                }
                
                Feature("Casing", isExpanded: $settingsViewModel.casingOn) {
                    HStack(spacing: 50) {
                        Text("Type")
                        
                        Picker("", selection: $settingsViewModel.enabledCasingSetting) {
                            ForEach(Casing.allCases[1...]) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Feature("Furryspeak", isExpanded: $settingsViewModel.furryspeakEnabled) {
                    Toggle("Stutter", isOn: $settingsViewModel.stutterEnabled)
                }
                
                ProFeature("Repeat", isExpanded: $settingsViewModel.repeatEnabled) {
                    Slider(
                        value: $settingsViewModel.numberOfRepeats,
                        in: settingsViewModel.repeatsRange,
                        step: settingsViewModel.repeatsStep
                    )
                    HStack {
                        Text("Number of repeats:")
                        Spacer()
                        Text("\(Int(settingsViewModel.numberOfRepeats))")
                    }
                }
                
                ProFeature("Emojifier", isExpanded: $dummySwitch) {
                    Text("Not implemented.")
                }
                
                ProFeature("Zalgo", isExpanded: $dummySwitch) {
                    Text("Not implemented.")
                }
                
            }
            
        }
        .background(Color(uiColor: colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
        .navigationTitle("Meme Settings")
        .environmentObject(settingsViewModel)
    }
}

struct MemeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MemeSettingsView()
            .environmentObject(SettingsViewModel())
    }
}
