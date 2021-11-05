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
    
    var body: some View {
        VStack(spacing: 5.0) {
            
            Text(settingsViewModel.createFormattedString())
                .font(.system(size: 25))
                .lineLimit(nil)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .padding()
                .roundedBackground(color: Color(uiColor: .systemBackground))
                .padding(.horizontal)
            
            
            CopyPasteRegen().environmentObject(settingsViewModel)
            
            
            Form {
                
                ButtonDisclosureGroup("Spaces", isExpanded: $settingsViewModel.isSpaced) {
                    Stepper("Amount: \(settingsViewModel.numberOfSpaces)",
                            value: $settingsViewModel.numberOfSpaces,
                            in: settingsViewModel.spacesRange,
                            step: settingsViewModel.spacesStep)
                }
                
                ButtonDisclosureGroup("Casing", isExpanded: $settingsViewModel.casingOn) {
                    HStack(spacing: 50) {
                        Text("Casing Type")
                        
                        Picker("", selection: $settingsViewModel.enabledCasingSetting) {
                            ForEach(Casing.allCases[1...]) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                ButtonDisclosureGroup("Furryspeak", isExpanded: $settingsViewModel.furryspeakEnabled) {
                    Toggle("Stutter", isOn: $settingsViewModel.furryspeakEnabled)
                }
            }
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .navigationTitle("Meme Settings")
    }
}

struct MemeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemeSettingsView()
        }
    }
}
