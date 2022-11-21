//
//  KeyboardViewController.swift
//
//  Created by Joe Cardenas on 9/15/18.
//

import UIKit

import KeyboardKit
import SwiftUI
import Combine

class KeyboardViewController: KeyboardInputViewController {
 
    var viewModel = SettingsViewModel()
    var toastContext = ToastContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set m3Keys to only use English Locale
        keyboardContext.setLocale(.english)
        
        // Set custom keyboard behavior to stop automatic sentence ending
        keyboardBehavior = M3KKeyboardBehaivior(context: keyboardContext)
        
        // Set a custom action handler to add functionality
        keyboardActionHandler = M3KActionHandler(inputViewController: self, settingsViewModel: viewModel)
        
        // Setup a layout with .emojis instead of .dictation
        keyboardLayoutProvider = StandardKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: .keyboardType(.emojis))

        
        // Set the keyboard to load the view from SwiftUI
        // setup(with: keyboardView)
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        setup(with:
            KeyboardView(
                actionHandler: keyboardActionHandler
            )
            .environmentObject(viewModel)
            .environmentObject(toastContext)
        )
    }
    
}
