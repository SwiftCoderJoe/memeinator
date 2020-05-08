//
//  memeinator3000Tests.swift
//  memeinator3000Tests
//
//  Created by Joey C on 7/28/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//

import XCTest
@testable import memeinator3000

var memeUnderTest: ViewController!

class memeinator3000Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        memeUnderTest = ViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        memeUnderTest = nil
        super.tearDown()
    }
    
    func testingiguess() {
        memeUnderTest.spacingButtonFunction()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
