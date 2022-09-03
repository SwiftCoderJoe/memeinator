//
//  CenteredScrollView.swift
//
//  Created by Joe Cardenas on 7/24/22.
//

import Foundation
import SwiftUI

/// Centers content inside a ScrollView if the content doesn't take up the ScrollView's entire axis.
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
