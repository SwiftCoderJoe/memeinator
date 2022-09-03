//
//  Published+UserDefaults.swift
//
//  Created by Joe Cardenas on 12/15/21.
//

import Foundation
import Combine

private var cancellables = [String: AnyCancellable]()

/// This extension adds a simple way to include a published value in UserDefaults
extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults(suiteName: "group.memeinatorapps")!.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults(suiteName: "group.memeinatorapps")!.set(val, forKey: key)
        }
    }
}
