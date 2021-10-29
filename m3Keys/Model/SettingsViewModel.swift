//
//  memeSettings.swift
//  m3Keys
//
//  Created by Kids on 3/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 
ViewModel for M3Keys
 
 */
class SettingsViewModel: GenericViewModel {
    
    // MARK: Properties
    
    private var memeState = false
    
    // MARK: Methods
    
    /** Creates a formatted action based on the current user input and context. */
    func createFormattedAction(_ input: String, contextBefore: String) -> FormattedAction {
        var workingString = FormattedAction(input: input)
        
        workingString += formatCasing(from: workingString.formattedString, startingFrom: memeState)
        memeState.toggle()
        
        workingString += formatSpaces(from: workingString.formattedString)
        
        // Furryspeak not yet implemented.
        
        return workingString
    }
    
    /** Keyboard action containing instructions on how to create a memeinated version of the original string. */
    struct FormattedAction {
        init(input: String) {
            self.deletes = 0
            self.formattedString = input
        }
        
        init(deletes: Int, formattedString: String) {
            self.deletes = deletes
            self.formattedString = formattedString
        }
        
        var deletes: Int
        var formattedString: String
        
        static func += (lhs: inout Self, rhs: Self) {
            let deletes = lhs.deletes + rhs.deletes
            let formattedString = rhs.formattedString
            lhs = FormattedAction(deletes: deletes, formattedString: formattedString)
        }
        
        static func += (lhs: inout Self, rhs: String) {
            lhs = FormattedAction(deletes: lhs.deletes, formattedString: rhs)
        }
    }
    
}
