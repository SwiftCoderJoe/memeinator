//
//  Preference+FavoriteEnum.swift
//  memeinator3000
//
//  Created by Kids on 1/10/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import Combine

// This should probably be removed at some point
@propertyWrapper
class PublishedEnumPreference<Value: RawRepresentable>: Resettable, ObservableObject where Value.RawValue == String {
    @Published private var store: String
    private var initial: String
    
    init(wrappedValue: Value, key: String) {
        self.store = wrappedValue.rawValue
        self._store = Published(wrappedValue: wrappedValue.rawValue, key: key)
        self.initial = wrappedValue.rawValue
    }
    
    func reset() {
        store = initial
    }
    
    static subscript<T: ObservableObject> (
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, PublishedEnumPreference>
    ) -> Value {
        get {
            return Value(rawValue: instance[keyPath: storageKeyPath].store)!
        }
        set {
            instance[keyPath: storageKeyPath].store = newValue.rawValue
            let publisher = instance.objectWillChange
            (publisher as? ObservableObjectPublisher)?.send()
        }
    }
    
    @available(*, unavailable)
    var wrappedValue: Value {
        get { return Value(rawValue: store)! }
        set { store = newValue.rawValue }
    }
}
