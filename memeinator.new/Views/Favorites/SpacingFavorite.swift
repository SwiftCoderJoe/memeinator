//
//  SpacingFavorite.swift
//  memeinator.new
//
//  Created by Kids on 4/30/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

extension FavoriteViews {
    struct Spacing: View {
        @EnvironmentObject var viewModel: SettingsViewModel
        
        var body: some View {
            QuickSetting(named: "Spacing") {
                Toggle("", isOn: $viewModel.spacingEnabled)
                    .labelsHidden()
            }
        }
    }
}
