//
//  UITextDocumentProxy+Custom.swift
//  m3Keys
//
//  Created by Kids on 7/4/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import UIKit

public extension UITextDocumentProxy {
    
    /** Input content on the pasteboard, if there is any. */
    func paste() {
        if let pasteboard = UIPasteboard.general.string {
            insertText(pasteboard)
        }
    }
    
}
