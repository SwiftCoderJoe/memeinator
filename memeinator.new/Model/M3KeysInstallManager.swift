//
//  M3KeysInstallManager.swift
//
//  Created by Joe Cardenas on 1/22/22.
//

import Foundation
import UIKit

/// Checks if Memeinator Keyboard is installed on the user's system and if it has full access.
class M3KeysInstallManager: ObservableObject {
    init() {
        installed = getInstallState()
        fullAccess = getFullAccessState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Overwritten during init
    @Published var installed = false
    
    // Overwritten during init
    @Published var fullAccess = false
    
    func updateKeyboardState() {
        installed = getInstallState()
        fullAccess = getFullAccessState()
    }
    
    private func getInstallState() -> Bool {
        guard let
                keyboards = UserDefaults.standard.dictionaryRepresentation()["AppleKeyboards"] as? [String]
        else {
            print("Could not get UserDefaults keyboard list.")
            return false
        }
        
        for keyboard in keyboards where keyboard.hasPrefix("com.bb.memeinator.") {
            return true
        }
        
        return false
    }
    
    private func getFullAccessState() -> Bool {
        return UIInputViewController().hasFullAccess
    }
}
