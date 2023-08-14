//
//  KeyboardManager.swift
//
//  Created by Joe Cardenas on 8/25/21.
//

import Foundation
import UIKit

/// Makes the current keyboard state available.
class KeyboardManager: ObservableObject {
    @Published private(set) var keyboardIsShown = false
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIApplication.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIApplication.keyboardWillHideNotification, object: nil
        )
    }
    
    @objc private func keyboardWillShow() {
        keyboardIsShown = true
    }
    
    @objc private func keyboardWillHide() {
        keyboardIsShown = false
    }
    
}
