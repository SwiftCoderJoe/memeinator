//
//  LargeTextField.swift
//  LargeTextField
//
//  Created by Kids on 8/31/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct LargeTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 20))
            .padding(15)
    }
}

extension TextFieldStyle where Self == LargeTextFieldStyle {
    static var largeTextField: LargeTextFieldStyle {
        return LargeTextFieldStyle()
    }
}
