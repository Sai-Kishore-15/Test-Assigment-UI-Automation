//
//  ZeroCaseTest.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 23/04/21.
//

import XCTest

class Zero_Case_Test: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_isZeroCaseVisibleOnLaunch() {
        // Validates Zerocase and its elements when wifi is off 
        let app = XCUIApplication()
        app.launch()
        let zeroCaseIdentifier = AccessibilityIdentifiers.zeroCaseview
        let tryAgainIdentifier = AccessibilityIdentifiers.tryAgainButton
        let textNoConnectionIdentifier   = AccessibilityIdentifiers.textNoConnection
        let zeroCase = app.otherElements[zeroCaseIdentifier]
        let tryAgainbutton = app.otherElements[zeroCaseIdentifier].buttons[tryAgainIdentifier]
        let noConnectionLabel = app.otherElements[zeroCaseIdentifier]
            .staticTexts[textNoConnectionIdentifier]
        XCTAssertTrue(zeroCase.exists, "Zero Case does not exist")
        XCTAssertTrue(tryAgainbutton.exists)
        XCTAssertTrue(noConnectionLabel.exists)
    }
}
