//
//  SpacingFavorite.swift
//
//  Created by Joe Cardenas on 4/30/22.
//

import Foundation
import SwiftUI

extension FavoriteViews {
    /// A quick toggle for toggling the spacing function.
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
