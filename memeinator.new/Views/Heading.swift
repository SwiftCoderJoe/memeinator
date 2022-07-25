//
//  LargeDivider.swift
//  LargeDivider
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

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
