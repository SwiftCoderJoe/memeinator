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
    
    // MARK: Methods
    
    func createFormattedString() -> String {
        var workingString = textInput
        
        workingString = formatCasing(workingString)
        
        workingString = formatSpaces(workingString)
        
        return workingString
    }
}
