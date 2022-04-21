//
//  Meme_AppsTests.swift
//  Meme AppsTests
//
//  Created by Gilang Ramadhan on 21/04/22.
//

import XCTest

class MemeAppsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
      let value = 10
      let anotherValue = 20
      XCTAssertEqual( value + anotherValue, anotherValue + value)
    }

}
