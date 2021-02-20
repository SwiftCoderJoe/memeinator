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
    @IBOutlet var spaceButton: UIButton!
    @IBOutlet var spaceLabel: UILabel!
    
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
        
        spaceButton = UIButton(type: .system) as UIButton
        spaceButton.translatesAutoresizingMaskIntoConstraints = false
        //button.frame = CGRect(x:50, y:50, width:100, height:50)
        
        self.view.addSubview(spaceButton)
        
        spaceLabel = UILabel()
        spaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(spaceLabel)
        
        NSLayoutConstraint.activate([
            self.view.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            spaceButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            spaceButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            spaceButton.topAnchor.constraint(equalTo: self.view.topAnchor),
            spaceButton.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor),
            spaceLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            spaceLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            spaceLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            spaceLabel.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor),
            self.nextKeyboardButton.heightAnchor.constraint(equalToConstant: 25),
            self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.nextKeyboardButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        
        
        spaceButton.isUserInteractionEnabled = true
        spaceButton.isEnabled = true
        spaceButton.setBackgroundImage(purpleGradient, for: .normal)
        //button.setBackgroundImage(purpleGradient, for: .normal)
        let normalFont = UIFont.boldSystemFont(ofSize: 80)
        let normalAttributes = [NSAttributedString.Key.font: normalFont]
        let normalTitle = NSAttributedString(string: "S P A C E", attributes: normalAttributes)
        spaceButton.setAttributedTitle(normalTitle, for: .normal)
        let disabledTitle = NSAttributedString(string: "")
        spaceButton.setAttributedTitle(disabledTitle, for: .disabled)
        spaceButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        spaceLabel.isHidden = true
        spaceLabel.text = "Select Text First"
        spaceLabel.textAlignment = .center
        spaceLabel.font = UIFont.boldSystemFont(ofSize: 40)

    }
    
    @objc func buttonClicked(button: UIButton) {
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
            
            // Create s p a c e d chars
            var textToSend = ""
            for char in selectedChars {
                textToSend.append("\(char) ")
            }
            
            // Send s p a c e d string
            cursor.insertText(textToSend)
            
            cursor.deleteBackward()
            
        } else {
            spaceLabel.isHidden = false
            spaceButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self.setButtonEnabled()
            })
        }
        
    }
    
    
    func setButtonEnabled() {
        spaceLabel.isHidden = true
        spaceButton.isEnabled = true
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

