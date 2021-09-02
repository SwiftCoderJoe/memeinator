//
//  M3KActionHandler.swift
//  m3Keys
//
//  Created by Kids on 3/25/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import KeyboardKit
import SwiftUI

class M3KActionHandler: StandardKeyboardActionHandler {
    
    // MARK: Init
    
    // Same init as inherited, with SettingsViewModel added
    public init(inputViewController: KeyboardViewController, settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        self.inputViewController = inputViewController
        
        super.init(inputViewController: inputViewController)
        
    }
    
    // Stores global SettingsViewModel
    private var settingsViewModel: SettingsViewModel
    private var inputViewController: KeyboardViewController
    
    // MARK: Handling
    
    // Called every button press
    override func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        
        // Only add a space after actions that should have a space after them.
        if gesture == .tap, let action = customTapAction(for: action) {
            return action
        }
        
        return super.action(for: gesture, on: action)
    }
    
    // Return a custom action, or the standard action
    func customTapAction(for action: KeyboardAction) -> GestureAction? {
        switch action {
        
        case .character(let char): return {
            $0?.textDocumentProxy.insertText(self.settingsViewModel.createFormattedString(char))
        }

        case .space: return {
            $0?.textDocumentProxy.insertText(self.settingsViewModel.createFormattedString(" "))
        }

        case .emoji(let emoji): return {
            $0?.textDocumentProxy.insertText(self.settingsViewModel.createFormattedString(emoji.char))
        }
    
        // If some other key is pressed, return nil (breaks if and returns super.action)
        default:
            break
        }
        
        return nil
    }
    
    // MARK: Custom Handling
    
    func tryPaste() -> Bool {
        if inputViewController.hasFullAccess {
            inputViewController.textDocumentProxy.paste()
            return true
        } else {
            return false
        }
    }
    
}
