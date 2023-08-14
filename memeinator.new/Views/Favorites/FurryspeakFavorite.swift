//
//  FurryspeakFavorite.swift
//
//  Created by Joe Cardenas on 4/30/22.
//

import Foundation
import SwiftUI

extension FavoriteViews {
    /// A quick toggle for toggling the furryspeak function.
    struct FurryspeakFavorite: View {
        @EnvironmentObject var viewModel: SettingsViewModel
        
        var body: some View {
            QuickSetting(named: "Furryspeak") {
                Toggle("", isOn: $viewModel.furryspeakEnabled)
                    .labelsHidden()
            }
        }
    }
}
