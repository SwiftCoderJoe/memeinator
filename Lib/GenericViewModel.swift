//
//  File.swift
//  File
//
//  Created by Kids on 8/26/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

/**
 A generic ObservableObject for interacting with the current meme settings.
 */
class GenericViewModel: ObservableObject {
    
    // MARK: All
    
    /** Transaction handler */
    var store = Store()
    
    /** Pro feature that is used, or nil. */
    var proFeature: String? {
        if repeatEnabled {
            return "Repeat"
        } else {
            return nil
        }
    }
    
    // MARK: Spacing
    
    /** Pusblished value showing if spacing is enabled. */
    @Published var spacingEnabled = false
    
    /** Pusblished value showing the number of spaces per character. */
    @Published var numberOfSpaces = 1
    
    /** Integer range value showing the possible range of spaces per character. */
    let spacesRange = 1...5
    
    /** Integer value showing the step of the spacing stepper UI element. */
    let spacesStep = 1
    
    func formatSpaces(from input: String) -> String {
        guard spacingEnabled else {
            return input
        }
        
        var workingString = ""
        
        for character in input {
            workingString.append(character)
            workingString.append(String(repeating: " ", count: numberOfSpaces))
        }
        
        return workingString
    }
    
    // MARK: Casing
    
    /** Published value expressing the current selected casing setting. */
    @Published var casingSetting: Casing = .none {
        didSet {
            if casingSetting != .none {
                lastEnabledCasingSetting = casingSetting
            }
        }
    }
    
    /** Computed variable expressing if casing is currently enabled. */
    var casingOn: Bool {
        get {
            return casingSetting != .none
        }
        
        set(value) {
            if value {
                casingSetting = lastEnabledCasingSetting
            } else {
                lastEnabledCasingSetting = casingSetting
                casingSetting = .none
            }
            
        }
    }
    
    /**
     If casing is enabled, memeinator will use this casing setting.
     
     This value CANNOT be .none
     */
    var enabledCasingSetting: Casing {
        get {
            if casingSetting == .none {
                return lastEnabledCasingSetting
            } else {
                return casingSetting
            }
        }
        
        set(value) {
            if casingOn {
                casingSetting = value
            } else {
                lastEnabledCasingSetting = value
            }
        }
        
    }
    
    /** Private value which stores the last used casing setting. */
    private var lastEnabledCasingSetting: Casing = .meme
    
    func formatCasing(from input: String, startingFrom state: Bool = false) -> String {
        var workingString = ""
        var memeState = state
        
        switch casingSetting {
        case .none:
            workingString = input
        case .meme:
            for character in input {
                workingString.append(memeState ? character.uppercased() :
                                                 character.lowercased())
                memeState.toggle()
            }
        case .random:
            for character in input {
                workingString.append(randomBool() ? character.uppercased() :
                                                    character.lowercased())
            }
        }
        
        return workingString
    }
    
    // MARK: Furryspeak
    
    @Published var furryspeakEnabled = false
    
    @Published var stutterEnabled = false
    
    // Not in use by m3keys, remember to update m3keys please
    func formatFurryspeak(from input: String) -> String {
        guard furryspeakEnabled else {
            return input
        }
        
        
        var workingString = ""
        var prevChar = ""
        var lastTwo = ""

        for char in input {
            lastTwo = prevChar + String(char)
            
            if char == "L" || char == "R" {         // L and R to W
                workingString.append("W")
            } else if char == "l" || char == "r" {
                workingString.append("w")
            } else if lastTwo == "th" {
                workingString = String(workingString.dropLast())// TH to D
                workingString.append("d")
            } else if lastTwo == "Th" || lastTwo == "TH" {
                workingString = String(workingString.dropLast())
                workingString.append("D")
            } else {                                // NONE
                workingString.append(char)
            }
            
            prevChar = String(char)
        }
        
        return workingString

    }
    
    // Stutter
    
    /** The probability of each word to stutter is 1 in this number. */
    let stutterProbability: UInt32 = 15
    
    // MARK: Repeat
    
    /** Published value showing if Repeat is enabled. */
    @Published var repeatEnabled = false
    
    /** Published value showing the number of times to repeat. */
    @Published var numberOfRepeats = 2.0
    
    /** Value showing the possible range of repeats. */
    let repeatsRange = 1.0...100.0
    
    /** Value showing the step of a repeat control. */
    let repeatsStep = 1.0
    
    func repeatString(_ input: String) -> String {
        guard repeatEnabled else {
            return input
        }
        
        return String(repeating: input, count: Int(numberOfRepeats))
        
    }
}

enum Casing: String, CaseIterable, Identifiable, Hashable {
    case none = "None"
    case meme = "mEmE"
    case random = "rAnDOm"
    
    var id: String { self.rawValue }
}
