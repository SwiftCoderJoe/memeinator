//
//  EnabledSetting.swift
//  memeinator.new
//
//  Created by L David Cardenas on 11/21/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Combine

@propertyWrapper
class EnabledSetting {
    var store: Bool
    private var pro: Bool
    private var stringRepresentation: String
    
    init(wrappedValue: Bool, pro: Bool, name: String) {
        store = wrappedValue
        self.pro = pro
        stringRepresentation = name
    }
    
    static subscript<T: ObservableObject> (
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Bool>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, EnabledSetting>
    ) -> Bool {
        get {
            return instance[keyPath: storageKeyPath].store
        }
        set {
            let publisher = instance.objectWillChange
            (publisher as? ObservableObjectPublisher)?.send()
            
            instance[keyPath: storageKeyPath].store = newValue
        }
    }
    
    func isProAndEnabled() -> String? {
        if store && pro {
            return stringRepresentation
        } else {
            return nil
        }
    }
    
    // Never available. Do not use.
    @available(*, unavailable, message: "Subscript is used instead of wrappedValue")
    var wrappedValue: Bool {
        get { fatalError("") }
        set { fatalError(newValue.description) }
    }
}
