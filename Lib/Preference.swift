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
    
    // Store is where the value is actually stored, but encoded as Data. Published allows it to be stored in UserDefaults.
    @Published private var store: Data
    
    // The initial value, set by whatever is to the right of the equals sign.
    private var initial: Data
    
    // Use this wrapper to encode anything that is codable. Must be used because for some reason where Value: Codable is not enough.
    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }
    
    // Encode the initial value, set both the Store and Initial to the enoded value.
    init(wrappedValue: Value, key: String) {
        
        do {
            let codedValue = try PropertyListEncoder().encode(Wrapper(wrapped: wrappedValue))
            
            self.store = codedValue
            
            // This published provides UserDefaults
            self._store = Published(wrappedValue: codedValue, key: key)
            self.initial = codedValue
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Just reset the variable to its initial value.
    func reset() {
        store = initial
    }
    
    static subscript<T: ObservableObject> (
        _enclosingInstance instance: T,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<T, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<T, PublishedPreference>
    ) -> Value {
        get {
            
            // Store variable, defined above
            let store = instance[keyPath: storageKeyPath].store
            
            do {
                // Decode stored value
                let wrappedValue = try PropertyListDecoder().decode(Wrapper<Value>.self, from: store)
                
                // Return it
                return wrappedValue.wrapped
            } catch {
                fatalError(error.localizedDescription)
            }
            
            
        }
        set {
            do {
                // Encode the value
                let codedValue = try PropertyListEncoder().encode(Wrapper(wrapped: newValue))
                // Set store to the encoded value
                instance[keyPath: storageKeyPath].store = codedValue
                
                // Send objectWillChange
                let publisher = instance.objectWillChange
                (publisher as? ObservableObjectPublisher)?.send()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // Never available. Do not use.
    @available(*, unavailable, message: "Subscript is used instead of wrappedValue")
    var wrappedValue: Value {
        get { fatalError("") }
        set { fatalError(newValue as! String) }
    }
}

/// Marks a function as being resettable to a starting value.
protocol Resettable {
    func reset()
}

/// Marks an object as being able to reset all child resettables.
protocol PreferenceContainer: ObservableObject {
    func resetPreferences()
}

/// Adds a default reset function to all ObservableObject PreferenceContainers
extension PreferenceContainer where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func resetPreferences() {
        
        let mirror = Mirror(reflecting: self)
        
        // Tracks if an objectWillChange should be sent
        var reset = false
        
        // Get all resettables from the object
        let resettables = mirror.children
            .compactMap { child in
                return child.value as? Resettable
            }
        
        // Reset each resettable. Reset is set to true if anything has been reset.
        for resettable in resettables {
            resettable.reset()
            reset = true
        }
        
        // Do the same thing but with a single superclass.
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
        
        // If anything has reset then send an objectWillChange
        if reset {
            objectWillChange.send()
        }
    }
}
