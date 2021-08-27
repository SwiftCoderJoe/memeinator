//
//  memeSettings.swift
//  m3Keys
//
//  Created by Kids on 3/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

/**
 
Class for interacting with the current meme settings. SettingsInteractable has a singleton which contains information about exactly what the current settings are on the keybaord.

 */
class SettingsViewModel: ObservableObject {
    init() {
        
    }
    
    // MARK: Spacing
    
    /** Pusblished value showing if spacing is enabled on m3Keys. */
    @Published var isSpaced = false
    
    /** Pusblished value showing the number of spaces per character on m3Keys. */
    @Published var numberOfSpaces = 1
    
    /** Integer range value showing the possible range of spaces per character on m3Keys. */
    let spacesRange = 1...5
    
    /** Integer value showing the step per click of spaces per character on m3Keys. */
    let spacesStep = 1
    
    // MARK: Casing
    
    /** Published value expressing the current selected casing setting on m3Keys. */
    @Published var casingSetting = Casing.none
    
    /** Private state variable that shows weather the next character should be lowercase or uppercase in meme casing. True is uppercase. */
    private var memeState = false
    
    // MARK: Functions
    
    /** Creates a single-character string with the correct formatting as defined by the current state of the SettingsViewModel */
    func createFormattedString(_ character: String) -> String {
        var string = character
        
        // Format the character
        switch casingSetting {
        case .none:
            memeState = false
        case .meme:
            string = memeState ? string.uppercased() : string.lowercased()
            memeState.toggle()
        case .random:
            memeState = false
            string = randomBool() ? string.uppercased() : string.lowercased()
        }
        
        // Add spaces
        if isSpaced {
            string.append(String(repeating: " ", count: numberOfSpaces))
        }
        
        return string
    }
    
}


enum Casing: String, CaseIterable, Identifiable, Hashable {
    case none = "None"
    case meme = "mEmE"
    case random = "rAnDOm"
    
    var id: String { self.rawValue }
}
