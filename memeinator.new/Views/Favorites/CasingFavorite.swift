//
//  CasingFavorite.swift
//  memeinator.new
//
//  Created by Kids on 4/30/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

extension FavoriteViews {
    struct CasingFavorite: View {
        @EnvironmentObject var viewModel: SettingsViewModel
        
        var body: some View {
            QuickSetting(named: "Casing") {
                Picker(selection: $viewModel.casingSetting,
                       label: Text(viewModel.casingSetting.rawValue)
                ) {
                    ForEach(Casing.allCases) {
                        Text($0.rawValue)
                            .font(.system(size: 15))
                            .tag($0)
                    }
                }
                .frame(width: 65, height: 31)
                .roundedBackground(color: Color(uiColor: .systemBackground))
            }
        }
    }
}
