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
    
    private var randomCasingState = [randomBool()]
    
    // MARK: Methods
    
    func createFormattedString() -> String {
        var workingString = textInput
        
        workingString = formatCasing(from: workingString)
        
        workingString = formatFurryspeak(from: workingString)
        
        workingString = formatSpaces(from: workingString)
        
        return workingString
    }
    
    func randomizeState() {
        self.objectWillChange.send()
        randomCasingState.randomize()
    }
    
    override func formatCasing(from input: String, startingFrom state: Bool = false) -> String {
        switch casingSetting {
        case .random:
            var workingString = ""
            for idx in 0..<input.count {
                if idx < randomCasingState.count {
                    randomCasingState.append(randomBool())
                }
                
                let character = input[input.index(input.startIndex, offsetBy: idx)]
                
                workingString.append(randomCasingState[idx] ? character.uppercased() :
                                                            character.lowercased())
            }
            return workingString
        default:
            return super.formatCasing(from: input)
        }
    }
}
