//
//  UITextDocumentProxy+Custom.swift
//
//  Created by Joe Cardenas on 7/4/21.
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
