//
//  LargeTextField.swift
//
//  Created by Joe Cardenas on 8/31/21.
//

import Foundation
import SwiftUI

/// A TextField style with larger padding and font size.
struct LargeTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 20))
            .padding(15)
    }
}

extension TextFieldStyle where Self == LargeTextFieldStyle {
    /// A TextField style with larger padding and font size.
    static var largeTextField: LargeTextFieldStyle {
        return LargeTextFieldStyle()
    }
}
