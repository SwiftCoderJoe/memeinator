//
//  Published+UserDefaults.swift
//  memeinator3000
//
//  Created by Kids on 12/15/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

private var cancellables = [String: AnyCancellable]()

extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}
