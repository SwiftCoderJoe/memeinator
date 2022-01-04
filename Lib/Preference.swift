//
//  PreferencesContainer.swift
//  memeinator.new
//
//  Created by Kids on 1/3/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import Combine

/** Only works on children of GenericViewModel
 
 DO NOT USE IN OTHER SITUATIONS: Is this the best way to do this? Almost definitely not. Does it work? I think so. Make of that what you will. */
@propertyWrapper
class PublishedPreference<Value>: Resettable, ObservableObject {
    @Published private var store: Value
    private var initial: Value
    
    init(wrappedValue: Value, key: String) {
        self.store = wrappedValue
        self._store = Published(wrappedValue: wrappedValue, key: key)
        self.initial = wrappedValue
    }
    
    func reset() {
        store = initial
    }
    
    static subscript<T: ObservableObject> (
            _enclosingInstance instance: T,
            wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
            storage storageKeyPath: ReferenceWritableKeyPath<T, PublishedPreference>
        ) -> Value {
            get {
                return instance[keyPath: storageKeyPath].store
            }
            set {
                instance[keyPath: storageKeyPath].store = newValue
                let publisher = instance.objectWillChange
                (publisher as? ObservableObjectPublisher)?.send()
            }
        }
    
    var wrappedValue: Value {
        get { return store }
        set { store = newValue }
    }
}

protocol Resettable {
    func reset()
}

protocol PreferenceContainer: ObservableObject {
    func resetPreferences()
}

extension PreferenceContainer where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func resetPreferences() {
        let children = Mirror(reflecting: self)
            .superclassMirror!.children
        
        let resettables = children.compactMap { child in
            return child.value as? Resettable
        }
        
        for resettable in resettables {
            resettable.reset()
        }
        
        if resettables.count > 0 {
            objectWillChange.send()
        }
    }
}
