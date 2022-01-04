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
private var isPro = [String: Bool]()

extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults(suiteName: "group.memeinatorapps")!.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults(suiteName: "group.memeinatorapps")!.set(val, forKey: key)
        }
    }
}
