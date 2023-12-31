//
//  DaVinciFavorite.swift
//
//  Created by Joe Cardenas on 4/30/22.
//

import Foundation
import SwiftUI

extension FavoriteViews {
    /// A quick toggle for toggling the da vinci function.
    struct DaVinciFavorite: View {
        @EnvironmentObject var viewModel: SettingsViewModel
        
        var body: some View {
            QuickSetting(named: "Da Vinci") {
                Toggle("", isOn: $viewModel.daVinciEnabled)
                    .labelsHidden()
            }
        }
    }
}
