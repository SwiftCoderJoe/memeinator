//
//  memeinator3000Tests.swift
//  memeinator3000Tests
//
//  Created by Joey C on 7/28/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//

import XCTest
@testable import memeinator3000


class memeinator3000Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCombinationMeme() {
        let model = MemeSettings.instance
        model.isSpaced = true
        model.spaces = 3
        model.selectedCase = 1
        model.isFurryspeak = true
        
        let test = model.createMemedText(currentInput: "The Quick Brown Fox Jumps Over The Lazy Dog. :)")
        
        XCTAssertEqual(combinationMemeStatic, test, "Actual: \(test)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        let model = MemeSettings.instance
        model.isSpaced = true
        model.spaces = 3
        model.selectedCase = 1
        model.isFurryspeak = true
        
        self.measure {
            // Put the code you want to measure the time of here.
            _ = model.createMemedText(currentInput: lorem)
        }
    }
    
    // swiftlint:disable line_length
    let combinationMemeStatic = "t   D   e       q   U   i   C   k       b   W   o   W   n       f   O   x       j   U   m   P   s       o   V   e   W       T   d   E       W   a   Z   y       d   O   g   .       :   )"
    
    
    let lorem = "Lorem ipsum dolor sit amet. Et modi quidem qui inventore saepe ut corrupti fugiat ex nisi minima hic quos distinctio aut repudiandae architecto ut suscipit assumenda. Qui aliquam recusandae est incidunt iusto cum rerum earum et cupiditate deserunt et perspiciatis delectus. Est maxime doloribus qui pariatur nesciunt et voluptatem amet qui doloremque aliquid ex enim adipisci aut iure debitis. Ut accusantium reiciendis cum eveniet quae ut soluta perspiciatis! "
}
