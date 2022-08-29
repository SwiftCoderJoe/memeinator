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
                            .font(.body)
                            .tag($0)
                    }
                }
                .frame(height: 31)
                .roundedBackground(color: Color(uiColor: .systemBackground))
                // Alright I know that sounds bad...
                // So basically I have no control over the label here. AFAICT I can't change the font size or basically anything else, which means that I can't limit the lines and force the picker to truncate. This would be fine, except that on DTS xxxL on an iPhone SE 3rd (which I hope to support, BTW), it creates two lines. So here we are. You could try fixing this again later if you want.
                .dynamicTypeSize(...DynamicTypeSize.xxLarge)

            }
        }
    }
}
