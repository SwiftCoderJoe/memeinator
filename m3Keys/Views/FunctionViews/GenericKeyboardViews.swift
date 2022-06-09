//
//  GenericKeyboardViews.swift
//  m3Keys
//
//  Created by Kids on 3/25/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

/// Generic Keyboard Function. Sets everything to be placed in an HStack, sets font, font color, padding, and sizing, but does not create a background.
fileprivate struct GenericKeyboardFunction<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        .foregroundColor(.white)
        .font(.system(size: 15).bold())
        .frame(maxHeight: .infinity)
        .padding(.horizontal)
    }
}

/// A generic button to place on Memeinator Keyboard with a given title and action.
struct KeyboardButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        GenericKeyboardFunction {
            Button(title, action: action)
        }
        .roundedBackground(color: .gray)
    }
}

struct KeyboardFunction<Content: View>: View {
    let title: String
    @Binding var isEnabled: Bool
    let content: Content?
    
    init(named title: String, enabled: Binding<Bool>) where Content == AnyView {
        self.title = title
        _isEnabled = enabled
        content = nil
    }
    
    init(named title: String, enabled: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        _isEnabled = enabled
        self.content = content()
    }
    
    var body: some View {
        _KeyboardFunction(named: title, enabled: $isEnabled) {
            content
        } closedContent: {
            // Intentionally Left Blank
        }
        
    }
    
}

struct ProKeyboardFunction<Content: View>: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    let title: String
    @Binding var isEnabled: Bool
    let content: Content?
    
    init(named title: String, enabled: Binding<Bool>) where Content == AnyView {
        self.title = title
        _isEnabled = enabled
        content = nil
    }
    
    init(named title: String, enabled: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        _isEnabled = enabled
        self.content = content()
    }
    
    var body: some View {
        _KeyboardFunction(named: title, enabled: $isEnabled) {
            content
        } closedContent: {
            // FIXME: Test if this is correct pro to use, or store pro since last update instead
            ProBadge(pro: viewModel.store.pro)
        }
    }
    
}

fileprivate struct _KeyboardFunction<OpenContent: View, ClosedContent: View>: View {
    let title: String
    @Binding var isEnabled: Bool
    let openContent: OpenContent
    let closedContent: ClosedContent
    
    init(named title: String, enabled: Binding<Bool>, @ViewBuilder openContent: () -> OpenContent, @ViewBuilder closedContent: () -> ClosedContent) {
        self.title = title
        _isEnabled = enabled
        self.openContent = openContent()
        self.closedContent = closedContent()
    }
    
    var body: some View {
        GenericKeyboardFunction {
            Button(title, action: {
                isEnabled.toggle()
            })
            
            if let content = openContent, isEnabled {
                Divider()
                content
            } else if let content = closedContent {
                content
            }
        }
        .roundedBackground(color: isEnabled ? .purple : .gray)
    }
}
