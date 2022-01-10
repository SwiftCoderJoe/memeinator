//
//  Favorites.swift
//  memeinator.new
//
//  Created by Kids on 1/8/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct QuickSetting: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let setting: Favorite
    
    init(for setting: Favorite) {
        self.setting = setting
    }
    
    var body: some View {
        switch setting {
        case .spacing:
            _QuickSetting(named: setting.rawValue) {
                Toggle("", isOn: $settingsViewModel.spacingEnabled)
                    .labelsHidden()
            }
        case .casing:
            _QuickSetting(named: setting.rawValue) {
                Picker(selection: $settingsViewModel.casingSetting,
                       label: Text(settingsViewModel.casingSetting.rawValue)
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
        case .furryspeak:
            _QuickSetting(named: setting.rawValue) {
                Toggle("", isOn: $settingsViewModel.furryspeakEnabled)
                    .labelsHidden()
            }
        case .davinci:
            _QuickSetting(named: setting.rawValue) {
                Toggle("", isOn: $settingsViewModel.daVinciEnabled)
                    .labelsHidden()
            }
        }
    }
    
    private struct _QuickSetting<Content: View>: View {
        let content: Content
        let name: String
        
        init(named name: String, @ViewBuilder content: () -> Content) {
            self.content = content()
            self.name = name
        }
        
        var body: some View {
            VStack {
                Text(name)
                    .font(.system(size: 15))
                    .lineLimit(1)
                content
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(Color(uiColor: .systemBackground))
        }
    }
}

enum Favorite: String, CaseIterable, Identifiable {
    case spacing = "Spacing"
    case casing = "Casing"
    case furryspeak = "Furryspeak"
    case davinci = "Da Vinci"
    
    var id: String {
        self.rawValue
    }
    
    var quickSetting: QuickSetting {
        QuickSetting(for: self)
    }
}
