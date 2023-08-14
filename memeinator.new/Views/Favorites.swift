//
//  Favorites.swift
//
//  Created by Joe Cardenas on 1/8/22.
//

import Foundation
import SwiftUI

struct FavoriteViews { }

/// Generic quick setting template that includes a background and title.
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
                .font(.body)
                .lineLimit(1)
            content
        }
        .padding(.vertical)
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(Color(uiColor: .systemBackground))
    }
}

/// List of all quick settings and their respective views
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
