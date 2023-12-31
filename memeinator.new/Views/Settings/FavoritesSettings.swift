//
//  FavoritesSettings.swift
//
//  Created by Joe Cardenas on 1/9/22.
//

import Foundation
import SwiftUI

/// "Favorites" page of the Memeinator More tab.
struct FavoritesSettings: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Form {
            ProGroup(name: "Left") {
                
                Picker("Left Favorite",
                       selection: $settingsViewModel.leftQuickSetting) {
                    ForEach(Favorite.allCases) {
                        if settingsViewModel.shouldShowQuickSetting(favorite: $0, in: .left) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
            }
            
            ProGroup(name: "Center") {
                Picker("Center Favorite",
                       selection: $settingsViewModel.centerQuickSetting) {
                    ForEach(Favorite.allCases) {
                        if settingsViewModel.shouldShowQuickSetting(favorite: $0, in: .center) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
            }
            
            ProGroup(name: "Right") {
                Picker("Right Favorite", selection: $settingsViewModel.rightQuickSetting) {
                    ForEach(Favorite.allCases) {
                        if settingsViewModel.shouldShowQuickSetting(favorite: $0, in: .right) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoritesSettings_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSettings()
            .environmentObject(SettingsViewModel())
    }
}
