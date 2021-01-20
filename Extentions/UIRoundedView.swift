//
//  UIRoundedView.swift
//  memeinator3000
//
//  Created by Kids on 1/18/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import UIKit

@IBDesignable
class UIRoundedView: UIView {

    @IBInspectable var radius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.radius
        self.layer.masksToBounds = true
    }
}


