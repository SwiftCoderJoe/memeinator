//
//  CenteredScrollView.swift
//  memeinator3000
//
//  Created by Kids on 7/24/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct CenteredScrollView<Content: View>: View {
    let axis: Axis.Set
    let content: Content
    
    init(_ axis: Axis.Set = .vertical, @ViewBuilder content: () -> Content) {
        self.axis = axis
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(axis) {
                content
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
