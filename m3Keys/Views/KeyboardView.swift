//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

/**
 This view is the main view that is used by the extension by
 calling `setup(with:)` in `KeyboardViewController`.
 
 The view will switch over the current keyboard type and add
 the correct keyboard view.
 */
struct KeyboardView: View {
    
    // Standard appearance and layout provider
    var appearance: KeyboardAppearance
    var layoutProvider: KeyboardLayoutProvider
    
    // Custom M3KActionHandler
    var actionHandler: KeyboardActionHandler
    
    // Global SettingsViewModel inherited from KeyboardViewController.swift
    @EnvironmentObject var viewModel: SettingsViewModel
    
    // Standard keyboardContext and toastContext
    @EnvironmentObject var keyboardContext: KeyboardContext
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    
    var body: some View {
        keyboardView.keyboardToast(
            context: toastContext,
            background: toastBackground)
    }
    
    // ViewBuilder for main keyboard, switches based on keyboard type to emojiKeyboard (no m3k functionality for emojis yet)
    @ViewBuilder
    var keyboardView: some View {
        switch keyboardContext.keyboardType {
        case .alphabetic, .numeric, .symbolic: systemKeyboard
        case .emojis: emojiKeyboard
        default: Button("???", action: switchToDefaultKeyboard)
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    // optionsView from OptionsView.swift -- shows meme options and settings
    var optionsView: some View {
        OptionsView()
            .environmentObject(viewModel)
            .frame(height: 55)
    }

    // Emoji Keyboard (Requires iOS 14) (No m3k functionality yet)
    @ViewBuilder
    var emojiKeyboard: some View {
        if #available(iOSApplicationExtension 14.0, *) {
            EmojiCategoryKeyboard().padding(.vertical)
        } else {
            Text("Requires iOS 14 or later")
        }
    }
    
    // Main system keyboard with symbols
    var systemKeyboard: some View {
        VStack(spacing: 0) {
            optionsView
            SystemKeyboard(
                layout: layoutProvider.keyboardLayout(for: keyboardContext),
                appearance: appearance,
                actionHandler: actionHandler,
                buttonBuilder: buttonBuilder)
        }
    }
    
    // Toasts
    var toastBackground: some View {
        Color.white
            .cornerRadius(3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
    }
}


// MARK: - Private Functions

private extension KeyboardView {
    
    func buttonBuilder(action: KeyboardAction) -> AnyView {
        switch action {
        case .space: return AnyView(SystemKeyboardSpaceButtonContent())
        default: return SystemKeyboard.standardButtonBuilder(action: action)
        }
    }
    
    func changeLocale(to locale: LocaleKey) {
        DispatchQueue.main.async {
            KeyboardInputViewController.shared.changeKeyboardLocale(to: locale.locale)
        }
    }
    
    func localeButton(title: String, locale: LocaleKey) -> some View {
        Button(title) {
            changeLocale(to: locale)
        }
    }
    
    func switchToDefaultKeyboard() {
        actionHandler
            .handle(.tap, on: .keyboardType(.alphabetic(.lowercased)))
    }
}