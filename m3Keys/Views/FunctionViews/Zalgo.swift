//
//  Zalgo.swift
//  m3Keys
//
//  Created by Kids on 6/2/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI
import KeyboardKit

struct ZalgoFunction: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    var body: some View {
        ProKeyboardFunction(named: "Zalgo", enabled: $viewModel.zalgoEnabled) {
            Stepper(value: $viewModel.zalgoHeight,
                    in: viewModel.zalgoHeightRange,
                    step: viewModel.zalgoHeightStep) {
                
                // FIXME: This and other numbers in m3keys should probably have fixed width
                Text("Height: \(Int(viewModel.zalgoHeight))")
                    .font(.subheadline)
            }
        }
    }
}
