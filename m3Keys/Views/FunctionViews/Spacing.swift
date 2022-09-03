//
//  SpacingFunction.swift
//
//  Created by Joe Cardenas on 4/13/22.
//

import Foundation
import SwiftUI

struct SpacingFunction: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        KeyboardFunction(named: "Spacing", enabled: $viewModel.spacingEnabled) {
            Stepper(value: $viewModel.numberOfSpaces,
                    in: viewModel.spacesRange,
                    step: viewModel.spacesStep) {
                
                Text("\(viewModel.numberOfSpaces)")
                    .font(.subheadline)
            }
        }
    }
}
