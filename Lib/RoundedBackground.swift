//
//  RoundedBackground.swift
//
//  Created by Joe Cardenas on 8/28/21.
//

import Foundation
import SwiftUI

extension View {
    /// Adds a rounded background of the specified color behind the original view.
    ///
    /// Corner radius is 10.
    func roundedBackground(color: Color) -> some View {
        modifier(RoundedBackground(color: color))
    }
}

struct RoundedBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        return content
            .background(color, in: RoundedRectangle(cornerRadius: 10))
    }
}
