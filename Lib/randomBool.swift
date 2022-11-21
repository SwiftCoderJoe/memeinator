//
//  randomBool.swift
//
//  Created by Joe Cardenas on 6/9/21.
//

import Foundation

/// Returns a random boolean using Int.random.
func randomBool() -> Bool {
    return Int.random(in: 0...2) == 0
}

/// Returns a random boolean using Int.random with the given chance. For example, `randomBool(in: 10)` has a 1/10 chance of being true.
func randomBool(in chance: Int) -> Bool {
    return Int.random(in: 0...chance) == 0
}

extension Array where Element == Bool {
    /// Fills an array of Bools with random Bools
    mutating func randomize() {
        for idx in 0..<self.count {
            self[idx] = randomBool()
        }
    }
    
    /// Fills an array of Bools with random Bools with a 1 in `chance` chance of being true.
    mutating func randomize(in chance: Int) {
        for idx in 0..<self.count {
            self[idx] = randomBool(in: chance)
        }
    }
}
