//
//  KeyboardManager.swift
//  KeyboardManager
//
//  Created by Kids on 8/25/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import UIKit

class KeyboardManager: ObservableObject {
    @Published private(set) var keyboardIsShown = false
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIApplication.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow() {
        keyboardIsShown = true
    }
    
    @objc private func keyboardWillHide() {
        keyboardIsShown = false
    }
    
}
