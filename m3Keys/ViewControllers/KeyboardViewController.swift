//
//  KeyboardViewController.swift
//  memeinator but its a keyboard
//
//  Created by Joe Cardenas on 9/15/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//

import UIKit

import KeyboardKit
import SwiftUI
import Combine

class KeyboardViewController: KeyboardInputViewController {
 
    var viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set m3Keys to only use English Locale
        keyboardContext.locale = LocaleKey.english.locale
        
        keyboardContext.locales = [
            LocaleKey.english.locale
        ]
        
        // Set custom keyboard behavior to stop automatic sentence ending
        keyboardBehavior = M3KKeyboardBehaivior(context: keyboardContext)
        
        // Set a custom action handler to add functionality
        keyboardActionHandler = M3KActionHandler(inputViewController: self, settingsViewModel: viewModel)
        
        // Set an input set provider with only English
        keyboardInputSetProvider = StandardKeyboardInputSetProvider(context: keyboardContext, providers: [EnglishKeyboardInputSetProvider()])
        
        // Setup a layout with .emojis instead of .dictation
        keyboardLayoutProvider = StandardKeyboardLayoutProvider(inputSetProvider: keyboardInputSetProvider, dictationReplacement: .keyboardType(.emojis))

        
        // Set the keyboard to load the view from SwiftUI
        setup(with: keyboardView)
    }
    
    // MARK: Properties
    
    private lazy var toastContext = KeyboardToastContext() // This allows you to use "Toasts" which are basically popups as far as I understand it. What's with companies naming random UI elements based on foods? "Snackbar", anyone?
    
    // Main keyboard view built from KeyboardView.swift
    private var keyboardView: some View {
        KeyboardView(
            appearance: keyboardAppearance,
            layoutProvider: keyboardLayoutProvider,
            actionHandler: keyboardActionHandler)
            .environmentObject(viewModel)
            .environmentObject(toastContext)
    }
    
}