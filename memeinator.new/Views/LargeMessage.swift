//
//  LargeMessage.swift
//  memeinator.new
//
//  Created by Kids on 1/22/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct LargeMessage: View {
    var iconName: String
    var message: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 60))

            Text(message)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Color(uiColor: .systemBackground))
        .padding()
        .roundedBackground(color: .purple)
    }
}

struct WideMessage: View {
    var iconName: String
    var message: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 60))

            Text(message)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Color(uiColor: .systemBackground))
        .padding()
        .frame(maxWidth: .infinity)
        .roundedBackground(color: .purple)
        .padding()
    }
}
