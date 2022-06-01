//
//  DaVinciFavorite.swift
//  memeinator.new
//
//  Created by Kids on 4/30/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

extension FavoriteViews {
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
