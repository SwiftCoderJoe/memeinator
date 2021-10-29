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
    @StateObject private var disclosureStates = DisclosureStates()
    
    var body: some View {
        Form {
            TextDisclosureGroup("Spacing", isExpanded: $disclosureStates.spacingOpened) {
                Toggle("Enabled", isOn: $settingsViewModel.isSpaced)
            }
            
            TextDisclosureGroup("Casing", isExpanded: $disclosureStates.casingOpened) {
                Toggle("Enabled", isOn: $settingsViewModel.casingOn)
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
            
            TextDisclosureGroup("Furryspeak", isExpanded: $disclosureStates.furryspeakOpened) {
                Toggle("Enabled", isOn: $settingsViewModel.furryspeakEnabled)
            }
        }
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

private class DisclosureStates: ObservableObject {
    
    init() {
        spacingOpened = persistedSpacingOpened
        casingOpened = persistedCasingOpened
        furryspeakOpened = persistedFurryspeakOpened
    }
    
    // Spacing
    @Published var spacingOpened: Bool = true {
        didSet { persistedSpacingOpened = spacingOpened }
    }
    
    @Persisted(key: "com.bb.meminator.state.spacingOpened", defaultValue: true)
    private var persistedSpacingOpened: Bool
    
    
    // Casing
    @Published var casingOpened: Bool = true {
        didSet { persistedCasingOpened = casingOpened }
    }
    
    @Persisted(key: "com.bb.meminator.state.casingOpened", defaultValue: true)
    private var persistedCasingOpened: Bool
    
    // Furryspeak
    @Published var furryspeakOpened: Bool = true {
        didSet { persistedFurryspeakOpened = furryspeakOpened }
    }
    
    @Persisted(key: "com.bb.meminator.state.furryspeakOpened", defaultValue: true)
    private var persistedFurryspeakOpened: Bool
}
