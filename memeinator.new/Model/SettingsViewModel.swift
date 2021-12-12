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
    
    private var casingState: [Bool] = []
    
    private var furryspeakState: [Bool] = []
    
    private var zalgoState: ZalgoState = ZalgoState()
    
    // MARK: Methods
    
    func createFormattedString() -> String {
        var workingString = textInput
        
        workingString = repeatString(workingString)
        
        workingString = formatFurryspeak(from: workingString)
        
        workingString = formatCasing(from: workingString)
        
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
    
    // Save furryspeak stutter state
    override func formatFurryspeak(from input: String) -> String {
        guard stutterEnabled && furryspeakEnabled else {
            return super.formatFurryspeak(from: input)
        }
        
        let words = super.formatFurryspeak(from: input)
            .split(separator: " ", omittingEmptySubsequences: false)
        var workingString = ""
        
        for (idx, word) in words.enumerated() {
            var word = String(word)
            
            // Don't add a space to the last word
            if idx + 1 < words.count {
                 word += " "
            }
            
            // Add more state if needed
            if idx >= furryspeakState.count {
                furryspeakState.append(randomBool(in: 15))
            }
            
            // If the word is just a space or empty, add it without stuttering
            if word == " " || word == "" {
                workingString.append(word)
                continue
            }
            
            workingString.append(furryspeakState[idx] ?
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
            
            
            // Next, if this character doesn't have a number of diacritics assigned to it, then create one using current parameters
            if zalgoState.diacriticsCountTop.count <= idx {
                zalgoState.diacriticsCountTop.append(Int(zalgoHeight))
            }
            
            if zalgoState.diacriticsCountBottom.count <= idx {
                zalgoState.diacriticsCountBottom.append(Int(zalgoHeight))
            }
            
            if zalgoState.randomnessModifierBottom.count <= idx {
                zalgoState.randomnessModifierBottom.append(
                    Int(arc4random_uniform(UInt32(zalgoRandomness * 2))) - Int(zalgoRandomness)
                )
            }
            
            if zalgoState.randomnessModifierTop.count <= idx {
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
            furryspeakState.randomize(in: stutterProbability)
            zalgoState = ZalgoState()
            
        case .furryspeak:
            furryspeakState.randomize(in: stutterProbability)
            
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
