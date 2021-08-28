//
//  KeyboardView.swift
//  KeyboardView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Text("Keyboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            LargeDivider()
            Spacer()
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
