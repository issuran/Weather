//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }

    func testHomeElements() throws {
        XCTAssert(app.staticTexts["Home"].exists)
        XCTAssert(app.buttons["Next"].exists)
        app.buttons["Next"].tap()
    }
    
    func testCurrentWeatherElements() throws {
        XCTAssert(app.buttons["Next"].exists)
        app.buttons["Next"].tap()
        
        XCTAssert(app.buttons["Back"].exists)
        app.buttons["Back"].tap()
    }
}
