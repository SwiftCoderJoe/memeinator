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
 
 It's certainly possible I could rewrite this into a protocol, extension, and structures but that seems to much work for literally no benefit.

 */
class GenericViewModel : ObservableObject {
    
    // MARK: Spacing
    
    /** Pusblished value showing if spacing is enabled. */
    @Published var isSpaced = false
    
    /** Pusblished value showing the number of spaces per character. */
    @Published var numberOfSpaces = 1
    
    /** Integer range value showing the possible range of spaces per character. */
    let spacesRange = 1...5
    
    /** Integer value showing the step of the spacing stepper UI element. */
    let spacesStep = 1
    
    func formatSpaces(_ string: String) -> String {
        var workingString = ""
        
        for character in string {
            workingString.append(character)
            workingString.append(String(repeating: " ", count: numberOfSpaces))
        }
        
        return workingString
    }
    
    // MARK: Casing
    
    /** Published value expressing the current selected casing setting. */
    @Published var casingSetting = Casing.none
    
    func formatCasing(_ string: String, startsFrom state: Bool = false) -> String {
        var workingString = ""
        var memeState = state
        
        switch casingSetting {
        case .none:
            workingString = string
        case .meme:
            for character in string {
                workingString.append(memeState ? character.uppercased() : character.lowercased())
                memeState.toggle()
            }
        case .random:
            for character in string {
                workingString.append(randomBool() ? character.uppercased() : character.lowercased())
            }
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
