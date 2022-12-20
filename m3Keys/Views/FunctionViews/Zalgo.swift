//
//  Zalgo.swift
//
//  Created by Joe Cardenas on 6/2/22.
//

import Foundation
import SwiftUI
import KeyboardKit

struct ZalgoFunction: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        ProKeyboardFunction(named: "Zalgo", enabled: $viewModel.zalgoEnabled) {
            Stepper(value: $viewModel.zalgoHeight,
                    in: viewModel.zalgoHeightRange,
                    step: viewModel.zalgoHeightStep) {
                
                Text("Height: \(Int(viewModel.zalgoHeight))")
            }
        }
    }
}
