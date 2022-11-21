//
//  M3KKeyboardBehaivior.swift
//
//  Created by Joe Cardenas on 3/25/21.
//

import Foundation
import KeyboardKit

class M3KKeyboardBehaivior: StandardKeyboardBehavior {
    
    // Force the keyboard to never autoend a sentence after two spaces
    override func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        return false
    }
    
    
    
}
