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
class PublishedPreference<Value>: Resettable, ObservableObject where Value: Codable {
    
    // TODO: document this shit please
    // god this is so horrible
    
    @Published private var store: Data
    private var initial: Data
    
    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }
    
    init(wrappedValue: Value, key: String) {
        
        do {
            let codedValue = try PropertyListEncoder().encode(Wrapper(wrapped: wrappedValue))
            
            self.store = codedValue
            self._store = Published(wrappedValue: codedValue, key: key)
            self.initial = codedValue
        } catch {
            fatalError(error.localizedDescription)
        }
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
            
            let store = instance[keyPath: storageKeyPath].store
            
            do {
                let wrappedValue = try PropertyListDecoder().decode(Wrapper<Value>.self, from: store)
                
                return wrappedValue.wrapped
            } catch {
                fatalError(error.localizedDescription)
            }
            
            
        }
        set {
            do {
                let codedValue = try PropertyListEncoder().encode(Wrapper(wrapped: newValue))
                instance[keyPath: storageKeyPath].store = codedValue
                let publisher = instance.objectWillChange
                (publisher as? ObservableObjectPublisher)?.send()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // NOT CALLED!!!
    var wrappedValue: Value {
        get { fatalError("stop") }
        set { fatalError("stop") }
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
        
        // This code is very bad!
        
        let mirror = Mirror(reflecting: self)
        
        var reset = false
        
        // Reset regular properties
        let children = mirror.children
        
        let resettables = children.compactMap { child in
            return child.value as? Resettable
        }
        
        for resettable in resettables {
            resettable.reset()
            reset = true
        }
        
        // Reset superclass properties
        if let superMirror = mirror.superclassMirror {
            let children = superMirror.children
            
            let resettables = children.compactMap { child in
                return child.value as? Resettable
            }
            
            for resettable in resettables {
                resettable.reset()
                reset = true
            }
        }
        
        if reset {
            objectWillChange.send()
        }
    }
}
