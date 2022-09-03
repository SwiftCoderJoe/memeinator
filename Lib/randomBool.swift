//
//  randomBool.swift
//
//  Created by Joe Cardenas on 6/9/21.
//

import Foundation

/// Returns a random boolean using arc4random_uniform.
func randomBool() -> Bool {
    return arc4random_uniform(2) == 0
}

/// Returns a random boolean using arc4random_uniform with the given chance. For example, `randomBool(in: 10)` has a 1/10 chance of being true.
func randomBool(in chance: UInt32) -> Bool {
    return arc4random_uniform(chance) == 0
}

/// Returns a random boolean using arc4random_uniform with the given chance. For example, `randomBool(in: 10)` has a 1/10 chance of being true.
func randomBool(in chance: Int) -> Bool {
    return arc4random_uniform(UInt32(chance)) == 0
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
