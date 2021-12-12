//
//  UnicodeLiterals.swift
//  memeinator3000
//
//  Created by Kids on 12/6/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

// swiftlint:disable line_length

import Foundation

/**
 Collections of useful unicode characters.
 
 Thanks to combatwombat and his [Lunicode.js project]( https://github.com/combatwombat/Lunicode.js ). These lists were largely formed from the code in his project.
 */
struct UnicodeLiterals {
    /** Diacritics to go on the top of a character. */
    static let diacriticsTop: [String] = ["̀", "́", "̂", "̃", "̄", "̅", "̆", "̇", "̈", "̉", "̊", "̋", "̌", "̍", "̎", "̏", "̐", "̑", "̒", "̓", "̔", "̕", "̚", "̛", "̽", "̾", "̿", "̀", "́", "͂", "̓", "̈́", "̈́", "͆", "͊", "͋", "͌", "͐", "͑", "͒", "͗", "͘", "͛", "͝", "͝", "͠", "͡"]
    
    /** Chooses and returns a random diacritic from the diacriticsTop list. */
    static func randomTopDiacritic() -> String {
        return diacriticsTop[
            Int(arc4random_uniform(
                UInt32(diacriticsTop.count)
            ))
        ]
    }
    
    /** Diacritics to go in the middle of a character. */
    static let diacriticsMiddle: [String] = ["̴", "̵", "̶", "̷", "̸"]
    
    /** Chooses and returns a random diacritic from the diacriticsMiddle list. */
    static func randomMiddleDiacritic() -> String {
        return diacriticsMiddle[
            Int(arc4random_uniform(
                UInt32(diacriticsMiddle.count)
            ))
        ]
    }
    
    /** Diacritics to go on the bottom of a character. */
    static let diacriticsBottom: [String] = ["̖", "̗", "̘", "̙", "̜", "̝", "̞", "̟", "̠", "̡", "̢", "̣", "̤", "̥", "̦", "̧", "̨", "̩", "̪", "̫", "̬", "̭", "̮", "̯", "̰", "̱", "̲", "̳", "̹", "̺", "̻", "̼", "ͅ", "͇", "͈", "͉", "͍", "͎", "͓", "͔", "͕", "͖", "͙", "͚", "͜", "͟"]

    /** Chooses and returns a random diacritic from the diacriticsBottom list. */
    static func randomBottomDiacritic() -> String {
        return diacriticsBottom[
            Int(arc4random_uniform(
                UInt32(diacriticsBottom.count)
            ))
        ]
    }
    
}
