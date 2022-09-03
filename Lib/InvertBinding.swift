//
//  InvertBinding.swift
//
//  Created by Joe Cardenas on 7/24/22.
//

import Foundation
import SwiftUI

/// A prefix operator that inverts the given binding.
prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
