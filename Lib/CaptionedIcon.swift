//
//  CaptionedIcon.swift
//
//  Created by Joe Cardenas on 7/24/22.
//

import Foundation
import SwiftUI

/// A view that includes an icon, title and caption. Especially useful in forms.
struct CaptionedIcon: View {
    let iconName: String
    let title: String
    let caption: String
    
    init(systemName iconName: String, title: String, caption: String) {
        self.iconName = iconName
        self.title = title
        self.caption = caption
    }
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(.purple)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                Text(caption)
                    .font(.footnote.weight(.light))
            }
            .foregroundColor(.primary)
            
            Spacer()
        }
    }
}
