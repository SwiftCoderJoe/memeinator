//
//  Furryspeak.swift
//  m3Keys
//
//  Created by Kids on 4/17/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct FurryspeakFunction: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        if viewModel.furryspeakStutterSeparated {
            KeyboardFunction(named: "Furryspeak", enabled: $viewModel.furryspeakEnabled)
            KeyboardFunction(named: "Stutter", enabled: $viewModel.stutterEnabled)
        } else {
            KeyboardFunction(named: "Furryspeak", enabled: $viewModel.furryspeakEnabled) {
                Text("Stutter:")
                
                // Enabled Toggle
                Toggle("Stutter Enabled", isOn: $viewModel.stutterEnabled)
                    .labelsHidden()
            }
        }
    }
}
