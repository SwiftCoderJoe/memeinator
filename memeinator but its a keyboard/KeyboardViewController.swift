//
//  KeyboardViewController.swift
//  memeinator but its a keyboard
//
//  Created by Kids on 9/15/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    // da22ff, 9733ee
    var purpleGradient = UIImage(named: "purpleGradient")
    
    var keyboardWidth:CGFloat = 10
    
    // MARK: IBOutlets
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        // MARK: Notification subscriptions
        
        //This allows me to get keyboard height
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let button = UIButton(type: .system) as UIButton
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.frame = CGRect(x:50, y:50, width:100, height:50)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            self.view.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            button.topAnchor.constraint(equalTo: self.view.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor),
            self.nextKeyboardButton.heightAnchor.constraint(equalToConstant: 25),
            self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.nextKeyboardButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        
        
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        print(purpleGradient)
        button.setBackgroundImage(purpleGradient, for: .normal)
        //button.setBackgroundImage(purpleGradient, for: .normal)
        button.setTitle("S P A C E", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 80)
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)

    }
    
    @objc func buttonClicked() {
        let cursor = self.textDocumentProxy
        print("Button Clicked")
        print(cursor.selectedText ?? "~~no value selected~~")
        print(cursor.selectedText?.count ?? "")
        print(cursor.documentContextBeforeInput ?? "~~no value before~~")
        print(cursor.documentContextBeforeInput?.count ?? "")
        print(cursor.documentContextAfterInput ?? "~~no value after~~")
        print(cursor.documentContextAfterInput?.count ?? "")
        
        if let selectedChars = cursor.selectedText {
            // If there is selected text, do this
            
            // Delete selected text
            cursor.deleteBackward()
            
            if let charsBeforeCursor = cursor.documentContextBeforeInput {
                if charsBeforeCursor[charsBeforeCursor.count - 1] == " " {
                    cursor.insertText(" ")
                }
            }
            
            // Insert s p a c e d chars
            for char in selectedChars {
                cursor.insertText("\(char) ")
            }
            
            cursor.deleteBackward()
            
        } else {
            // If the user had not selected any text, do this
            if let charsBeforeCursor = cursor.documentContextBeforeInput {
                
                // Go to one character before the beginning
                cursor.adjustTextPosition(byCharacterOffset: -(charsBeforeCursor.count) + 1)
                
                for char in charsBeforeCursor {
                    print(char)
                    cursor.deleteBackward()                             // Delete char
                    cursor.insertText(String(char))                     // Insert char
                    cursor.insertText(" ")                              // Insert space
                    cursor.adjustTextPosition(byCharacterOffset: 1)     // Go backwards to ready for the next char
                }
                
                cursor.adjustTextPosition(byCharacterOffset: -1)
                cursor.deleteBackward()
                
            }
            
            if let charsAfterCursor = cursor.documentContextAfterInput {
                for char in charsAfterCursor {
                    cursor.adjustTextPosition(byCharacterOffset: 1)
                    cursor.deleteBackward()
                    cursor.insertText("\(char) ")
                }
                cursor.deleteBackward()
                cursor.adjustTextPosition(byCharacterOffset: -(charsAfterCursor.count * 2)) // put the cursor back where it was before
            }
            
            
            
        }
        
        /*
        if let f = self.textDocumentProxy.documentContextBeforeInput {
            for letter in f {
                self.textDocumentProxy.deleteBackward()
            }
            for letter in f {
                self.textDocumentProxy.insertText("\(letter) ")
            }
        }
         */
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height)
            print("keyboardHeight",keyboardHeight)
        }

    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
