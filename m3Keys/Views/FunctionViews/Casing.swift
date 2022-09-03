//
//  CasingFunction.swift
//
//  Created by Joe Cardenas on 4/17/22.
//

import Foundation
import SwiftUI

struct CasingFunction: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        KeyboardFunction(named: "Casing", enabled: $viewModel.casingOn) {
            Picker("Casing Type", selection: $viewModel.enabledCasingSetting) {
                ForEach(Casing.allCases[1...]) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
