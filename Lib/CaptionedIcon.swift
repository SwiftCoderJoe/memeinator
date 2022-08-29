//
//  CaptionedIcon.swift
//  memeinator3000
//
//  Created by Kids on 7/24/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

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
