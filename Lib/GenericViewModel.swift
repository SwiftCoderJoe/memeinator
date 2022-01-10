//
//  File.swift
//  File
//
//  Created by Kids on 8/26/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import Combine

/**
 A generic ObservableObject for interacting with the current meme settings.
 */
class GenericViewModel: ObservableObject, PreferenceContainer {
    
    // MARK: All
    
    init() {
        
        // If the store changes, mark this object as changed.
        storePublisher = store.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
        
        // If the user does not own pro, reset all preferences
        storeProPublisher = store.proUpdatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { pro in
                if pro == false {
                    self.resetPreferences()
                }
            }
    }
    
    private var storePublisher: AnyCancellable?
    private var storeProPublisher: AnyCancellable?
    
    /** Transaction handler */
    @Published var store = Store()
    
    /** Pro feature that is used, or nil. */
    var proFeature: String? {
        if repeatEnabled {
            return "Repeat"
        } else if zalgoEnabled {
            return "Zalgo"
        } else {
            return nil
        }
    }
    
    func invalidateState(for invalidatedState: ViewModelState) {
        
    }
    
    enum ViewModelState {
        case all
        case furryspeak
        case casing
        case zalgoHeight
        case zalgoRandomness
        case zalgoDiacritics
    }
    
    // MARK: Settings
    
    /** UserDefaults stored value. If enabled, furryspeak and stutter are shown as two separate effects. */
    @PublishedPreference(key: "settings.v2.furryspeakStutterSeparated")
    var furryspeakStutterSeparated = false
    
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
    
    // MARK: Stutter
    
    /** The probability of each word to stutter is 1 in this number. */
    @PublishedPreference(key: "settings.v2.stutterProbability")
    var stutterProbability: Int = 5
    
    @Published var stutterEnabled = false
    
    /** Not implemented */
    func formatStutter(from input: String) -> String {
        return input
    }
    
    // MARK: Repeat
    
    /** Published value showing if Repeat is enabled. */
    @Published var repeatEnabled = false
    
    /** Published value showing the number of times to repeat. */
    @Published var numberOfRepeats = 2.0
    
    @PublishedPreference(key: "settings.v2.repeatsMax")
    var repeatsMax: Int = 25
    
    /** Value showing the possible range of repeats. */
    var repeatsRange: ClosedRange<Double> {
        1.0...Double(repeatsMax)
    }
    
    /** Value showing the step of a repeat control. */
    let repeatsStep = 1.0
    
    func repeatString(_ input: String) -> String {
        guard repeatEnabled else {
            return input
        }
        
        return String(repeating: input, count: Int(numberOfRepeats))
        
    }
    
    // MARK: Zalgo
    
    /** Published value showing if Zalgo is enabled. */
    @Published var zalgoEnabled = false
    
    /** Published value showing the height (number of diacritics) of zalgo. */
    @Published var zalgoHeight = 1.0 {
        didSet {
            if Int(oldValue) != Int(zalgoHeight) {
                invalidateState(for: .zalgoHeight)
            }
        }
    }
    
    /** Value showing the possible range of zalgo heights. */
    let zalgoHeightRange = 1.0...20.0
    
    /** Value showing the step of a zalgo height control. */
    let zalgoHeightStep = 1.0
    
    /**
     Value showing the randomness in height of zalgo.
     
     Randomness affects the number of diacritics. There will be `zalgoRange +/- (random 0...1) * zalgoRandomness` diacritics above and below each character.
     */
    @Published var zalgoRandomness = 0.0 {
        didSet {
            if Int(oldValue) != Int(zalgoRandomness) {
                invalidateState(for: .zalgoRandomness)
            }
        }
    }
    
    /** Value showing the possible range of zalgo randomness. */
    let zalgoRandomnessRange = 0.0...20.0
    
    /** Value showing the step of a zalgo randomness control. */
    let zalgoRandomnessStep = 1.0
    
    private var diacriticsCount: Int {
        return
            Int(zalgoHeight) +
            Int(arc4random_uniform(UInt32(zalgoRandomness * 2))) - Int(zalgoRandomness)
    }
        
    // Not used my memeinator, only m3keys
    func zalgoString(_ input: String) -> String {
        guard zalgoEnabled else {
            return input
        }
        
        var workingString = ""
        
        for character in input {
            
            workingString += String(character)
            
            for _ in 0..<diacriticsCount {
                workingString += UnicodeLiterals.randomTopDiacritic()
            }
            
            for _ in 0..<diacriticsCount {
                workingString += UnicodeLiterals.randomBottomDiacritic()
            }
            
        }
        
        return workingString
    
    }
    
    // MARK: Da Vinci
    
    /** Published value showing if Da Vinci flipping is enabled. */
    @Published var daVinciEnabled = false
    
    func formatDaVinci(from input: String) -> String {
        guard daVinciEnabled else {
            return input
        }
        
        var workingString = ""
        
        for element in input.reversed() {
            let character = String(element)
            
            workingString += UnicodeLiterals.daVinciCharacters[character] ?? character
        }
        
        return workingString
        
    }
}

enum Casing: String, CaseIterable, Identifiable, Hashable {
    case none = "None"
    case meme = "mEmE"
    case random = "rAnDOm"
    
    var id: String { self.rawValue }
}
