//
//  BetterUISegmentedControl.swift
//  memeinator3000
//
//  Created by Kids on 1/10/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import UIKit

class BetterUISegmentedControl : UISegmentedControl
{
    private var current:Int = UISegmentedControl.noSegment
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        current = self.selectedSegmentIndex
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if current == self.selectedSegmentIndex {
            self.sendActions(for: .valueChanged)
        }
    }
}
