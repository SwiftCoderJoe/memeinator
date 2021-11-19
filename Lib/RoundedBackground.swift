//
//  RoundedBackground.swift
//  RoundedBackground
//
//  Created by Kids on 8/28/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func roundedBackground(color: Color) -> some View {
        modifier(RoundedBackground(color: color))
    }
}

struct RoundedBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        return content
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color)
            }
    }
}
