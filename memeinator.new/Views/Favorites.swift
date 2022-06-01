//
//  Favorites.swift
//  memeinator.new
//
//  Created by Kids on 1/8/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct FavoriteViews { }

struct QuickSetting<Content: View>: View {
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

enum Favorite: String, CaseIterable, Identifiable, Codable {
    case spacing = "Spacing"
    case casing = "Casing"
    case furryspeak = "Furryspeak"
    case davinci = "Da Vinci"
    
    var id: String {
        self.rawValue
    }
    
    @ViewBuilder
    var quickSetting: some View {
        switch self {
        case .spacing:
            FavoriteViews.Spacing()
        case .casing:
            FavoriteViews.CasingFavorite()
        case .furryspeak:
            FavoriteViews.FurryspeakFavorite()
        case .davinci:
            FavoriteViews.DaVinciFavorite()
        }
    }
}
