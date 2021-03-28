//
//  M3KActionHandler.swift
//  m3Keys
//
//  Created by Kids on 3/25/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import KeyboardKit

class M3KActionHandler: StandardKeyboardActionHandler {
    
    // Same init as inherited, with SettingsViewModel added
    public init(inputViewController: KeyboardViewController, settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        
        super.init(inputViewController: inputViewController)
        
    }
    
    // Stores global SettingsViewModel
    private var settingsViewModel: SettingsViewModel
    
    // Called every button press
    override func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        
        // Check if spacing is enabled, and if it is, only add a space after actions that should have a space after them.
        if settingsViewModel.isSpaced && gesture == .tap, let action = tapActionWithSpace(for: action) {
            return action
        }
        
        return super.action(for: gesture, on: action)
    }
    
    // Return the standard action plus a space, or the system action
    func tapActionWithSpace(for action: KeyboardAction) -> GestureAction? {
        switch action {
        
        // Characters type character plus a space
        case .character(let char): return {
            $0?.textDocumentProxy.insertText(char + " ")
        }
        // Spaces type two spaces
        case .space: return {
            $0?.textDocumentProxy.insertText("  ")
        }
        
        // Emojis type emoji raw character, then space
        case .emoji(let emoji): return {
            $0?.textDocumentProxy.insertText(emoji.char + " ")
        }
        
        // If some other key is pressed, return nil
        default:
            break
        }
        
        return nil
    }
    
}
