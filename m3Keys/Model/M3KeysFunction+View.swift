//
//  M3KeysFunction+View.swift
//  m3Keys
//
//  Created by Kids on 3/25/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

extension M3KeysFunction {
    @ViewBuilder
    var view: some View {
        switch self {
        case .paste:
            PasteFunction()
        case .spacing:
            SpacingFunction()
        case .casing:
            CasingFunction()
        case .furryspeak:
            FurryspeakFunction()
        case .zalgo:
            ZalgoFunction()
        }
    }
}
