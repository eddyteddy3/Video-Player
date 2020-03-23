//
//  Unit Test.swift
//  Video Player
//
//  Created by Moazzam Tahir on 24/03/2020.
//  Copyright © 2020 Moazzam Tahir. All rights reserved.
//

import XCTest
import ViewInspector
@testable import MyApp

extension ContentView: Inspectable {
    
}



final class Unit_Test: XCtestCase {
    let post = DataStore.init()


    func testStringValue() throws {
        let sut = ContentView()
        let value = try sut.inspect().text().string()
        XCTAssertEqual(value, "How ")
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
