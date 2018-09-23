//
//  KeyboardViewController.swift
//  memeinator but its a keyboard
//
//  Created by Kids on 9/15/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        button.frame = CGRect(x:50, y:50, width:100, height:50)
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.backgroundColor = .black
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonClicked() {
        print("Button Clicked")
        print("\(self.textDocumentProxy.documentContextBeforeInput)")
        print("\(self.textDocumentProxy.documentContextAfterInput)")
        if let f = self.textDocumentProxy.documentContextBeforeInput {
            for letter in f {
                self.textDocumentProxy.deleteBackward()
            }
            for letter in f {
                self.textDocumentProxy.insertText("\(letter) ")
            }
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
