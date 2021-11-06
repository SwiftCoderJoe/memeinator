//
//  DeletableTextField.swift
//  memeinator.new
//
//  Created by Kids on 11/5/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct DeletableTextField: View {
    
    @Binding var text: String
    let label: String
    
    init(_ label: String, text: Binding<String>) {
        _text = text
        self.label = label
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        TextField(label, text: $text)
    }
}
