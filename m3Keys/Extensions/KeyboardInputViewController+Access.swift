//
//  KeyboardInputViewController+Access.swift
//  m3Keys
//
//  Created by Kids on 7/4/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import KeyboardKit

public extension KeyboardInputViewController {
    
    /** Returns true if the keyboard has full access. */
    var hasAccess: Bool {
        get{
            if #available(iOSApplicationExtension 11.0, *) {
                return self.hasFullAccess
            } else {
                return UIDevice.current.identifierForVendor != nil
            }
        }
    }
    
}
