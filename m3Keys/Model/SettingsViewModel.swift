//
//  memeSettings.swift
//
//  Created by Joe Cardenas on 3/23/21.
//

import Foundation
import KeyboardKit
import AlertToast

/**
 
ViewModel for M3Keys
 
 */
class SettingsViewModel: GenericViewModel {
    
    // MARK: Properties
    
    private var memeState = false
    
    // MARK: Methods
    
    /** Calculates the number of times the keyboard should deleteBackward based on context. */
    func deletes(contextBefore: String) -> Int {
        // If spacing is enabled and the last context is a character with a bunch of spaces
        if spacingEnabled && contextBefore.suffix(numberOfSpaces + 1).dropFirst(1).allSatisfy({
            return $0 == " "
        }) {
            return numberOfSpaces + 1
        }
        
        print("returning 1")
        return 1
    }
    
    /** Creates a formatted action based on the current user input and context. */
    func createFormattedAction(_ input: String, contextBefore: String) -> FormattedAction {
        var workingString = FormattedAction(input: input)
        
        workingString = createFurryspeakAction(from: workingString, with: contextBefore)
        
        workingString = createStutterAction(from: workingString, with: contextBefore)

        workingString = createCasingAction(from: workingString)

        workingString = createSpacingAction(from: workingString)
        
        workingString = createZalgoAction(from: workingString)
        
        return workingString
    }
    
    func createCasingAction(from input: FormattedAction) -> FormattedAction {
        guard casingOn else {
            return input
        }
        
        // If there are any deletes, make sure the memeState still lines up if we're in meme mode.
        if input.deletes % 2 == 1 && casingSetting == .meme {
            memeState.toggle()
        }
        
        // Create action
        let action = FormattedAction(
            deletes: input.deletes,
            formattedString: formatCasing(from: input.formattedString, startingFrom: memeState)
        )
        
        // Switch the casing state, only if we're in meme mode.
        if casingSetting == .meme {
            memeState.toggle()
        }
        
        return action
    }
    
    /**
     Returns an action with the characters modified with furryspeak patters, including stutter.
     
     Patterns include the following:
     - L and R become  W
     - TH becomes D
     - Stutter repeats the first character of a word with a hyphen. For example, "h-help". This is done if the context ends with nothing or a space.
     */
    func createFurryspeakAction(from input: FormattedAction, with context: String) -> FormattedAction {
        guard furryspeakEnabled else {
            return input
        }
        
        // start with no change
        var formattedAction = FormattedAction(input: input.formattedString)
        
        // Single character matches
        switch input.formattedString {
        case "R", "L":
            formattedAction = FormattedAction(input: "W")
        case "l", "r":
            formattedAction = FormattedAction(input: "w")
        default: break
        }
        
        // Two character matches
        
        let context = clean(context: context)
        let last = context.suffix(1)
        
        // Used below.
        func checkForStutter() {
            print("mark")
            let lastThree = String(context.suffix(3))
                        
            if lastThree.lowercased() == "t-t" {
                formattedAction = FormattedAction(
                    deletes: 3,
                    formattedString: formattedAction.formattedString + "-" + formattedAction.formattedString
                )
            }
        }
        // Replace th with d
        switch last + input.formattedString {
        case "TH", "Th", "tH":
            formattedAction = FormattedAction(deletes: 1, formattedString: "D")
            checkForStutter()
        case "th":
            formattedAction = FormattedAction(deletes: 1, formattedString: "d")
            checkForStutter()
        default: break
        }
        
        return formattedAction

    }
    
    func createStutterAction(from input: FormattedAction, with context: String) -> FormattedAction {
        guard stutterEnabled else {
            return input
        }
        
        let context = clean(context: context)
        let last = context.suffix(1)
        
        var formattedAction = input
        
        // If this is the beginning of a word or paragraph and random is true, stutter the char
        if (last == "" || last == " ") && randomBool(in: stutterProbability) {
            // Add a stutter
            formattedAction = FormattedAction(
                deletes: formattedAction.deletes,
                formattedString: formattedAction.formattedString + "-" + formattedAction.formattedString
            )
        }
        
        // We're done!
        return formattedAction
    }
    
    /** Returns an action with added spaces between characters and corrects deletes for the added spaces. */
    func createSpacingAction(from input: FormattedAction) -> FormattedAction {
        guard spacingEnabled else {
            return input
        }
        
        // Format spaces
        let formattedString = formatSpaces(from: input.formattedString)
        
        // Return formatted spaces with deletes corrected for added spaces.
        return FormattedAction(deletes: input.deletes * (numberOfSpaces + 1), formattedString: formattedString)
    }
    
    func createZalgoAction(from input: FormattedAction) -> FormattedAction {
        guard zalgoEnabled else {
            return input
        }
        
        let formattedString = zalgoString(input.formattedString)
        
        return FormattedAction(deletes: input.deletes, formattedString: formattedString)
    }
    
    /** Keyboard action containing instructions on how to create a memeinated version of the original string. */
    struct FormattedAction {
        /** Init with just a string. Sets deletes to 0. */
        init(input: String) {
            self.deletes = 0
            self.formattedString = input
        }
        
        /** Init with both deletes and a string. Deletes are performed first, then the string is typed.*/
        init(deletes: Int, formattedString: String) {
            self.deletes = deletes
            self.formattedString = formattedString
        }
        
        /** Number of times to deleteBackwards before the formattedString is typed. */
        var deletes: Int
        /** What is typed. */
        var formattedString: String
        
        /** Iterates the deletes property by the given number. */
        mutating func increaseDeletes(by number: Int) {
            deletes += number
        }
        
        /** Adds deletes and */
        static func += (lhs: inout Self, rhs: Self) {
            let deletes = lhs.deletes + rhs.deletes
            let formattedString = rhs.formattedString
            lhs = FormattedAction(deletes: deletes, formattedString: formattedString)
        }
        
        static func += (lhs: inout Self, rhs: String) {
            lhs = FormattedAction(deletes: lhs.deletes, formattedString: rhs)
        }
    }
    
    /**
     Removes spaces caused by Spacing from context
     Depending on the settings chosen by the user, this cannot always be done perfectly. In that case, clean() may return incorrect or garbled text.
     */
    func clean(context: String) -> String {
        guard context != "" else {
            return context
        }
        
        var context = context
        
        if zalgoEnabled {
            context = context.folding(options: .diacriticInsensitive, locale: nil)
        }
                
        if spacingEnabled {
            var formattedContext: [Character] = []
            let sectionLength = numberOfSpaces + 1
            
            // For every group of character and added spaces, extract the character and add it to a string.
            for _ in 0..<(context.count / sectionLength) {
                let section = String(context.suffix(sectionLength))
                
                formattedContext.insert(section.first!, at: 0)
                context.removeLast(sectionLength)
            }
            
            context = String(formattedContext)
        }
        
        return String(context)
    }
    
    
    
}
