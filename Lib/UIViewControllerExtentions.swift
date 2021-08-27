//
//  UIViewControllerExtention.swift
//  memeinator3000
//
//  Created by Kids on 1/10/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

