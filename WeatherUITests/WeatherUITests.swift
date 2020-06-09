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
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    override func setUp() {
        super.setUp()
        app.launch()
    }

    func testHomeElements() throws {
        app.buttons.element.tap()
        let passcodeInput = springboard.secureTextFields["Passcode field"]
        passcodeInput.tap()
        passcodeInput.typeText("abc\r")
        
        XCTAssert(app.staticTexts["Home"].exists)
        XCTAssert(app.buttons["Next"].exists)
        app.buttons["Next"].tap()
    }
    
    func testCurrentWeatherElements() throws {
        app.buttons.element.tap()
        let passcodeInput = springboard.secureTextFields["Passcode field"]
        passcodeInput.tap()
        passcodeInput.typeText("abc\r")
        
        XCTAssert(app.staticTexts["Home"].exists)
        XCTAssert(app.buttons["Next"].exists)
        app.buttons["Next"].tap()
        
        XCTAssert(app.buttons["Back"].exists)
        app.buttons["Back"].tap()
    }
    
    func testSecurityScreen() throws {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

        app.buttons.element.tap()
        let passcodeInput = springboard.secureTextFields["Passcode field"]
        passcodeInput.tap()
        passcodeInput.typeText("abc\r")
    }

}
