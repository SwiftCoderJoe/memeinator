//
//  MemeLogic.swift
//  memeinator3000
//
//  Created by Kids on 1/18/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//


/* There's a lot going on here. Also, singletons are bad apparently?
 
 Look, if this works then it works, but maybe we should practice a bit more than singletons.
 
 I suggest -- Protocol + Extension. Then we can move the */


import Foundation

class MemeSettings {
    static let instance = MemeSettings()
    
    private init() {
    }

    var currentInput = ""
    
    var currentGeneratedMeme = ""
    
    var isSpaced = true
    
    var spaces = 1
    
    var selectedCase = 0
    
    var isFurryspeak = false
    
    func setInputAndChangeState(input: String) {
        currentInput = input
        stateChanged()
    }
    
    func stateChanged() {
        
        currentGeneratedMeme = currentInput
        
        if isFurryspeak {
            translateTextToFurryspeak()
        }
        
        if selectedCase != 0 {
            capitalizeText()
        }
        
        if isSpaced {
            spaceText()
        }
        
        NotificationCenter.default.post(name: .didGenerateMeme, object: nil)
    }
    
    private func spaceText() {
        var workingMeme = ""
        
        for char in currentGeneratedMeme { // Iterate through each character and add a space for each stepper value
            
            workingMeme.append(char)
            
            for _ in 1...Int(spaces) {
                workingMeme.append(" ")
            }
            
        }
        
        if workingMeme != "" { // If there is text in the textbox, delete the last space(s)
            workingMeme = workingMeme[0..<(workingMeme.count - Int(spaces))]
        }
        
        // Finally, update the finalMemeLabel to reflect the new workingClipboard
        currentGeneratedMeme = workingMeme
    }
    
    private func capitalizeText() {
        var workingMeme = ""
        var caseState = 0
        
        for letter in currentGeneratedMeme {
            if selectedCase == 0 { // If "None" is selected for case, input normal case
                workingMeme.append(letter)
            } else if selectedCase == 1 { // If "mEmE" is selected for case, input alternating case
                if caseState == 0 {
                    caseState = 1
                    workingMeme.append(letter.lowercased())
                } else {
                    caseState = 0
                    workingMeme.append(letter.uppercased())
                }
            } else { // If "rAnDOm" is selected, choose randomly for each character
                if Int.random(in: 0...1) == 0 {
                    workingMeme.append(letter.lowercased())
                } else {
                    workingMeme.append(letter.uppercased())
                }
            }
            
        }
        
        currentGeneratedMeme = workingMeme
        
    }
    
    private func translateTextToFurryspeak() {
        var workingMeme = ""
        var prevChar = ""
        var lastTwo = ""

        for letter in currentGeneratedMeme {
            lastTwo = prevChar + String(letter)
            
            if letter == "L" || letter == "R" {         // L and R to W
                workingMeme.append("W")
            } else if letter == "l" || letter == "r" {
                workingMeme.append("w")
            } else if lastTwo == "th" {             // TH to D
                workingMeme.append("d")
            } else if lastTwo == "Th" || lastTwo == "TH" {
                workingMeme.dropLast()
                workingMeme.append("D")
            } else {                                // NONE
                workingMeme.append(letter)
            }
            
            prevChar = String(letter)
        }

        currentGeneratedMeme = workingMeme
        
    }
    
}
