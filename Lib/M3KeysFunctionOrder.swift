//
//  M3KeysFunctions.swift
//  memeinator.new
//
//  Created by Kids on 2/6/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation

enum M3KeysFunction: String, CaseIterable, Identifiable, Codable {
    case paste = "Paste"
    case spacing = "Spacing"
    case casing = "Casing"
    case furryspeak = "Furryspeak"
    case zalgo = "Zalgo"
    
    var pro: Bool {
        switch self {
        case .paste:
            return false
        case .spacing:
            return false
        case .casing:
            return false
        case .furryspeak:
            return false
        case .zalgo:
            return true
        }
    }
    
    var id: String {
        return self.rawValue
    }
}
