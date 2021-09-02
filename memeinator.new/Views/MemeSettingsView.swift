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
        Form {
            Section(header: Text("Casing")) {
                Toggle("Enabled", isOn: $settingsViewModel.isSpaced)
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
