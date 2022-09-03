//
//  GenericKeyboardViews.swift
//
//  Created by Joe Cardenas on 3/25/22.
//

import Foundation
import SwiftUI
import KeyboardKit

/// Generic Keyboard Function. Sets everything to be placed in an HStack, sets font, font color, padding, and sizing, but does not create a background.
private struct GenericKeyboardFunction<Content: View>: View {
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
        GenericKeyboardFunction {
            Button(title, action: {
                isEnabled.toggle()
            })
            
            if let content = content, isEnabled {
                Divider()
                content
            }
        }
        .roundedBackground(color: isEnabled ? .purple : .gray)
        
    }
    
}

struct ProKeyboardFunction<Content: View>: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var toastContext: KeyboardToastContext
    
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
        GenericKeyboardFunction {
            Button(action: {
                if viewModel.store.pro {
                    isEnabled.toggle()
                } else {
                    toastContext.present(
                        Text("Memeinator Pro is required.")
                            .font(.headline)
                            .foregroundColor(.gray)
                    )
                }
            }) {
                // This must be in an if instead of ?: operator because for some reason .titleOnly and .titleAndIcon are not the same type
                if viewModel.store.pro {
                    Label(title, systemImage: "lock")
                        .labelStyle(.titleOnly)
                } else {
                    Label(title, systemImage: "lock")
                        .labelStyle(.titleAndIcon)
                }
                
            }
            
            if let content = content, isEnabled {
                Divider()
                content
            }
        }
        .roundedBackground(color: isEnabled ? .purple : .gray)
    }
    
}
