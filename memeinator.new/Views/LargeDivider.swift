//
//  LargeDivider.swift
//  LargeDivider
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

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
