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
    
    @State private var casingDegrees = 0.0
    
    
    var body: some View {
        Form {
            TextDisclosureGroup("Spacing", isExpanded: $disclosureStates.spacingOpened) {
                Toggle("Enabled", isOn: $settingsViewModel.isSpaced)
            }
            
            TextDisclosureGroup("Casing", isExpanded: $disclosureStates.casingOpened) {
                // Spacing Content
                Picker("Type", selection: $settingsViewModel.casingSetting) {
                    ForEach(Casing.allCases) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
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
    }
    
    // Spacing
    @Published var spacingOpened: Bool = true {
        didSet { persistedSpacingOpened = spacingOpened }
    }
    
    @Persisted(key: "com.bb.meminator.state.spacingOpened", defaultValue: false)
    private var persistedSpacingOpened: Bool
    
    
    // Casing
    @Published var casingOpened: Bool = true {
        didSet { persistedCasingOpened = casingOpened }
    }
    
    @Persisted(key: "com.bb.meminator.state.casingOpened", defaultValue: false)
    private var persistedCasingOpened: Bool
}
