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
        // Succeeds when Internet Connectivity is Off
        // Fails when Internet Connectivity is On
        
        let app = XCUIApplication()
        app.launch()
        
        let zeroCase = app.otherElements["zero-case-view"]
        let tryAgainbutton = app.otherElements["zero-case-view"].buttons["try-again"]
        let noConnectionLabel = app.otherElements["zero-case-view"].staticTexts["text-no-connection"]
        
        XCTAssertTrue(zeroCase.exists, "Zero Case does not exist")
        XCTAssertTrue(tryAgainbutton.exists)
        XCTAssertTrue(noConnectionLabel.exists)
    }
}
