//
//  M3KKeyboardBehaivior.swift
//  m3Keys
//
//  Created by Kids on 3/25/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import KeyboardKit

class M3KKeyboardBehaivior: StandardKeyboardBehavior {
    
    // Force the keyboard to never autoend a sentence after two spaces
    override func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        return false
    }
    
}
