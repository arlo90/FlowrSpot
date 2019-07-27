//
//  FlowrSpotUITests.swift
//  FlowrSpotUITests
//
//  Created by Arijan Ljoki on 27/07/2019.
//  Copyright © 2019 PovioLabs. All rights reserved.
//

import XCTest

class FlowrSpotUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigation() {
        app.collectionViews.staticTexts["Alpski volcin"].tap()
        // Check if title of screen is correct
        XCTAssert(app.staticTexts["Alpski volcin"].exists)
        XCUIApplication().navigationBars["Alpski volcin"].buttons["FlowrSpot"].tap()
    }

    func createNewTest() {
        app.collectionViews.staticTexts["Alpski volcin"].tap()
        app.buttons["+ Add New Sighting?"].tap()
        // Check if title of screen is correct
        XCTAssert(app.staticTexts["Create new"].exists)
    }
}
