//
//  LargeDivider.swift
//
//  Created by Joe Cardenas on 8/24/21.
//

import SwiftUI

/// The top header of the three main Memeinator tabs.
struct Heading: View {
    init(_ name: String) {
        self.name = name
    }
    
    let name: String
    
    var body: some View {
        Text(name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.purple)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        LargeDivider()
    }
}

/// A purple, 4 pixel tall divider.
struct LargeDivider: View {
    var height: CGFloat = 4
    
    var body: some View {
        Rectangle()
            .foregroundColor(.purple)
            .frame(height: height)
    }
}

struct LargeDivider_Previews: PreviewProvider {
    static var previews: some View {
        LargeDivider()
    }
}
