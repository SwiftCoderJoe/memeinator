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
        if casingSetting == .meme {
            memeState.toggle()
        }
        
        workingString += createFurryspeakAction(from: workingString, with: contextBefore)
        
        workingString += createSpacingAction(from: workingString)
        
        
        return workingString
    }
    
    func createFurryspeakAction(from input: FormattedAction, with context: String) -> FormattedAction {
        guard furryspeakEnabled else {
            return input
        }
        
        // Single character matches
        switch input.formattedString {
        case "R", "L":
            return FormattedAction(input: "W")
        case "l", "r":
            return FormattedAction(input: "w")
        default: break
        }
        
        let string = clean(context: context) + input.formattedString
        
        // Two character matches
        
        switch string {
        case "TH", "Th", "tH":
            // If we're using meme casing, we should reset the meme state so it acts as if there had only been one letter
            if casingSetting == .meme {
                let letter = memeState ? "D" : "d"
                memeState.toggle()
                return FormattedAction(deletes: 1, formattedString: letter)
            }
            return FormattedAction(deletes: 1, formattedString: "D")
        case "th":
            return FormattedAction(deletes: 1, formattedString: "d")
        default:
            return input
        }

    }
    
    func createSpacingAction(from input: FormattedAction) -> FormattedAction {
        guard isSpaced else {
            return input
        }
        
        let formattedString = formatSpaces(from: input.formattedString)
        
        return FormattedAction(deletes: input.deletes * numberOfSpaces, formattedString: formattedString)
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
    
    func clean(context: String) -> String {
        guard context != "" else {
            return context
        }
        
        var formattedContext = context
        
        // Remove the number of spaces currently being used by Spacing from the end of the context
        if isSpaced && formattedContext.suffix(numberOfSpaces) == String(repeating: " ", count: numberOfSpaces) {
            formattedContext = String(formattedContext.dropLast(numberOfSpaces))
        }
        
        
        // Take only the last letter
        formattedContext = String(formattedContext.last!)
        
        return formattedContext
    }
    
}
