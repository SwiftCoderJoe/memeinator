//
//  memeSettings.swift
//  m3Keys
//
//  Created by Kids on 3/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

/**
 
ViewModel for M3Keys
 
 */
class SettingsViewModel: GenericViewModel {
    
    // MARK: Properties
    
    private var memeState = false
    
    // MARK: Overrides
    
    func createFormattedString(_ input: String) -> String {
        var workingString = input
        
        workingString = formatCasing(workingString, startsFrom: memeState)
        memeState.toggle()
        
        workingString = formatSpaces(workingString)
        
        return workingString
    }
}
