//
//  LargeMessage.swift
//
//  Created by Joe Cardenas on 1/22/22.
//

import Foundation
import SwiftUI

/// A large, centered header with a rounded purple background.
struct LargeMessage: View {
    var iconName: String
    var message: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 60))

            Text(message)
                .font(.system(size: 30))
                .lineLimit(nil)
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
