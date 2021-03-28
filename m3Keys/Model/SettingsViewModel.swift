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
    
    // Is spacing currently enabled
    @Published var isSpaced = false
    
}
