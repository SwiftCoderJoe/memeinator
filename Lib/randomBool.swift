//
//  File.swift
//  memeinator3000
//
//  Created by Kids on 6/9/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation

/** Returns a random boolean using arc4random_uniform. */
func randomBool() -> Bool {
    return arc4random_uniform(2) == 0
}

/** Returns a random boolean using arc4random_uniform with the given chance. For example, randomBool(in: 10) has a 1/10 chance of being true. */
func randomBool(in chance: UInt32) -> Bool {
    return arc4random_uniform(chance) == 0
}

extension Array where Element == Bool {
    mutating func randomize() {
        for idx in 0..<self.count {
            self[idx] = randomBool()
        }
    }
    
    mutating func randomize(in chance: UInt32) {
        for idx in 0..<self.count {
            self[idx] = randomBool(in: chance)
        }
    }
}
