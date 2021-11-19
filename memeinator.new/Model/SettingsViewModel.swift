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
    
    // MARK: Methods
    
    func createFormattedString() -> String {
        var workingString = textInput
        
        workingString = formatFurryspeak(from: workingString)
        
        workingString = formatCasing(from: workingString)
        
        workingString = formatSpaces(from: workingString)
        
        return workingString
    }
    
    func randomizeState() {
        self.objectWillChange.send()
        casingState.randomize()
        furryspeakState.randomize(in: stutterProbability)
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
        
        let words = input.split(separator: " ", omittingEmptySubsequences: false)
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
        
        return super.formatFurryspeak(from: workingString)
    }
}
