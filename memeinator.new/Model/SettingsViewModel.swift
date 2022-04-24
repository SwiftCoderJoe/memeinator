//
//  VIewModel.swift
//  VIewModel
//
//  Created by Kids on 8/26/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

class SettingsViewModel: GenericViewModel {
    
    // MARK: Properties
    
    /** Current TextField input text */
    @Published var textInput = ""
    
    @PublishedEnumPreference(key: "memeinator-settings.v1.leftQuickSetting")
    var leftQuickSetting: Favorite = .spacing
    
    @PublishedEnumPreference(key: "memeinator-settings.v1.centerQuickSetting")
    var centerQuickSetting: Favorite = .casing
    
    @PublishedEnumPreference(key: "memeinator-settings.v1.rightQuickSetting")
    var rightQuickSetting: Favorite = .furryspeak
    
    func shouldShowQuickSetting(favorite: Favorite, in section: FavoriteSection) -> Bool {
        switch section {
        case .left:
            return !(centerQuickSetting == favorite || rightQuickSetting == favorite)
        case .center:
            return !(leftQuickSetting == favorite || rightQuickSetting == favorite)
        case .right:
            return !(leftQuickSetting == favorite || centerQuickSetting == favorite)
        }
    }
    
    enum FavoriteSection {
        case left
        case center
        case right
    }
    
    private var casingState: [Bool] = []
    
    private var stutterState: [Bool] = []
    
    private var zalgoState: ZalgoState = ZalgoState()
    
    // MARK: Methods
    
    // FIXME: Refactor state so we can check state. called multiple times.
    func createFormattedString() -> String {
        print("Creating Formatted String for \"\(textInput)\"...")
        
        var workingString = textInput
        
        workingString = repeatString(workingString)
        
        workingString = formatFurryspeak(from: workingString)
        
        workingString = formatStutter(from: workingString)
        
        workingString = formatCasing(from: workingString)
        
        workingString = formatDaVinci(from: workingString)
        
        workingString = formatSpaces(from: workingString)
        
        workingString = formatZalgo(from: workingString)
        
        return workingString
    }
    
    func randomizeState() {
        invalidateState(for: .all)
    }
    
    // Save casing state
    override func formatCasing(from input: String, startingFrom state: Bool = false) -> String {
        switch casingSetting {
        case .random:
            var workingString = ""
            for (idx, character) in input.enumerated() {
                if idx >= casingState.count {
                    casingState.append(randomBool())
                }
                
                workingString.append(casingState[idx] ? character.uppercased() :
                                                        character.lowercased())
            }
            return workingString
        default:
            return super.formatCasing(from: input)
        }
    }
    
    override func formatStutter(from input: String) -> String {
        guard stutterEnabled && (furryspeakStutterSeparated || furryspeakEnabled) else {
            return input
        }
        
        let words = input.split(separator: " ", omittingEmptySubsequences: false)
        var workingString = ""
        
        for (idx, word) in words.enumerated() {
            var word = String(word)
            
            // Don't add a space to the last word
            if idx + 1 < words.count {
                 word += " "
            }
            
            // Add more state if needed
            if idx >= stutterState.count {
                stutterState.append(randomBool(in: stutterProbability))
            }
            
            // If the word is just a space or empty, add it without stuttering
            if word == " " || word == "" {
                workingString.append(word)
                continue
            }
            
            workingString.append(stutterState[idx] ?
                                 String(word.first!) + "-" + word :
                                 word)
        }
        
        return workingString
    }
    
    func formatZalgo(from input: String) -> String {
        guard zalgoEnabled else {
            return input
        }
        
        var workingString = ""
        
        for (idx, character) in input.enumerated() {
            
            // First, add the characters with no modifications
            workingString += String(character)
            
            // If state does not exist for this character, create it.
            if zalgoState.diacriticsTop.count <= idx {
                zalgoState.diacriticsTop.append([])
                zalgoState.diacriticsBottom.append([])
            }
            
            
            // Next, if this character doesn't have a height assigned to it, then create one using current parameters
            if zalgoState.diacriticsCountTop.count <= idx {
                zalgoState.diacriticsCountTop.append(Int(zalgoHeight))
                zalgoState.diacriticsCountBottom.append(Int(zalgoHeight))
            }
            
            // Next, if this character doesn't have a randomness modifier assigned to it, create it.
            if zalgoState.randomnessModifierBottom.count <= idx {
                zalgoState.randomnessModifierBottom.append(
                    Int(arc4random_uniform(UInt32(zalgoRandomness * 2))) - Int(zalgoRandomness)
                )
                zalgoState.randomnessModifierTop.append(
                    Int(arc4random_uniform(UInt32(zalgoRandomness * 2))) - Int(zalgoRandomness)
                )
            }
            
            
            // Then, add diacritics to the top and bottom of each character.
            // If the current state does not extend far enough, add more state.
            
            let topDiacriticsCount =
                max(zalgoState.diacriticsCountTop[idx] +
                    zalgoState.randomnessModifierTop[idx], 0)
            
            for diacriticNumber in 0..<topDiacriticsCount {
                if diacriticNumber >= zalgoState.diacriticsTop[idx].count {
                    zalgoState.diacriticsTop[idx]
                        .append(UnicodeLiterals.randomTopDiacritic())
                }
                
                workingString += zalgoState.diacriticsTop[idx][diacriticNumber]
                
            }
            
            let bottomDiacriticsCount =
                max(zalgoState.diacriticsCountBottom[idx] +
                    zalgoState.randomnessModifierBottom[idx], 0)
            
            for diacriticNumber in 0..<bottomDiacriticsCount {
                if diacriticNumber >= zalgoState.diacriticsBottom[idx].count {
                    zalgoState.diacriticsBottom[idx]
                        .append(UnicodeLiterals.randomBottomDiacritic())
                }
                
                workingString += zalgoState.diacriticsBottom[idx][diacriticNumber]
                
            }
            
        }
        
        return workingString
    }
    
    override func invalidateState(for invalidatedState: ViewModelState) {
        switch invalidatedState {
        case .all:
            casingState.randomize()
            stutterState.randomize(in: stutterProbability)
            zalgoState = ZalgoState()
            
        case .furryspeak:
            stutterState.randomize(in: stutterProbability)
            
        case .casing:
            casingState.randomize()
            
        case .zalgoHeight:
            zalgoState.diacriticsCountTop = []
            zalgoState.diacriticsCountBottom = []
            
        case .zalgoRandomness:
            zalgoState.randomnessModifierTop = []
            zalgoState.randomnessModifierBottom = []
            
        case .zalgoDiacritics:
            zalgoState.diacriticsTop = []
            zalgoState.diacriticsBottom = []
        }
        
        self.objectWillChange.send()
        
    }
}
