//
//  MemeLogic.swift
//  memeinator3000
//
//  Created by Kids on 1/18/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

class MemeSettings {
    static let instance = MemeSettings()
    
    private init() {
    }
    
    weak var displayDelegate: MemeDisplayDelegate?

    var currentGeneratedMeme = ""
    
    var isSpaced = false
    
    var spaces = 1
    
    var selectedCase = 0
    
    var isFurryspeak = false
    
    func setInputAndChangeState(input: String) {
        currentGeneratedMeme = input
        
        stateChanged()
    }
    
    func stateChanged() {
        if isSpaced {
            spaceText()
        }
        
        if selectedCase != 0 {
            capitalizeText()
        }
        
        if isFurryspeak {
            translateTextToFurryspeak()
        }
        
        displayDelegate?.memeWasGenerated(meme: currentGeneratedMeme)
        
    }
    
    private func spaceText() {
        var workingMeme = ""
        
        for _ in currentInputText { // Iterate through each character and add a space for each stepper value
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
        
        for letter in currentInputText {
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
                workingMeme.append("D")
            } else {                                // NONE
                workingMeme.append(letter)
            }
            
            prevChar = String(letter)
        }

        currentGeneratedMeme = workingMeme
    }
    
}

protocol MemeDisplayDelegate: class {
    func memeWasGenerated(meme: String)
}

/*
var workingMeme = ""

for letter in currentInputText { // Iterate through each character
    
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
    
    if spaceEnableSwitch.isOn { // Add a space for each stepper value if spacing is enabled
        for _ in 1...Int(stepper!.value) {
            workingMeme.append(" ")
        }
    }
    
}

if spaceEnableSwitch.isOn && workingClipboard != "" { // If spacing is enabled and there is text in the textbox, delete the last space(s)
    workingMeme = workingMeme[0..<(workingMeme.count - Int(stepper.value))]
}

// Finally, update the finalMemeLabel to reflect the new workingClipboard
currentGeneratedMeme = workingMeme
*/
