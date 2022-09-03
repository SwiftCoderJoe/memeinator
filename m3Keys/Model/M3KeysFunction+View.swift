//
//  M3KeysFunction+View.swift
//
//  Created by Joe Cardenas on 3/25/22.
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
