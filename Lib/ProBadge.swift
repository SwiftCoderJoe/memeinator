//
//  ProBadge.swift
//  memeinator.new
//
//  Created by Kids on 12/15/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct ProBadge: View {
    
    let pro: Bool
    
    let action: () -> Void
    
    var backgroundColor: Color = .purple
    var foregroundColor: Color = Color(uiColor: .systemGroupedBackground)
    
    init(pro: Bool) {
        self.pro = pro
        self.action = {}
    }
    
    init(pro: Bool, action: @escaping () -> Void) {
        self.pro = pro
        self.action = action
    }
    
    init(pro: Bool, action: @escaping () -> Void, backgroundColor: Color, foregroundColor: Color) {
        self.pro = pro
        self.action = action
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        if pro {
            Label("Pro", systemImage: "lock")
                .labelStyle(.titleOnly)
                .foregroundColor(foregroundColor)
                .padding(5)
                .background(backgroundColor, in: RoundedRectangle(cornerRadius: 5))
        } else {
            Button(action: action) {
                Label("Pro", systemImage: "lock")
                    .foregroundColor(foregroundColor)
                    .padding(5)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

/// No probadge, if you want probadge please edit the code to include that!
struct ProLink<Content: View, Destination: View>: View {
    
    let content: Content
    let getProAction: () -> Void
    let destination: Destination
    let pro: Bool
    
    init(pro: Bool, getProAction: @escaping () -> Void, destination: Destination, @ViewBuilder content: () -> Content) {
        self.pro = pro
        self.getProAction = getProAction
        self.destination = destination
        self.content = content()
    }
    
    init(pro: Bool, getProAction: @escaping () -> Void, destination: Destination, name: String) where Content == Text {
        self.pro = pro
        self.getProAction = getProAction
        self.destination = destination
        self.content = Text(name)
    }
    
    var body: some View {
        if pro {
            NavigationLink(destination: destination) {
                HStack {
                    Spacer()
                    
                    content

                    Image(systemName: "chevron.right")
                    
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
        } else {
            Button(action: getProAction) {
                Spacer()
                
                content
                
                Image(systemName: "chevron.right")
                
                Spacer()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
        }
    }
}
