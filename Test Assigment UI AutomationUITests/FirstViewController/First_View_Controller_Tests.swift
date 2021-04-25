//
//  First_View_Controller_Tests.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 24/04/21.
//

import XCTest

class First_View_Controller_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
     // DeInitialise propertiese
    }

    func test_validateTitle(){
        let app = XCUIApplication()
        app.launch()
        let navBarIdentifier = AccessibilityIdentifiers.navBarFirstViewController
        // does navigation bar with given identifier exist?
        let navBar = app.navigationBars[navBarIdentifier]
        XCTAssertTrue(navBar.exists,
                      getErrorMessage(type: "Navigation Bar",
                                      identifier: "\(navBarIdentifier)")
        )
        // does Navigation Item title with given identifier exist?
        let navItemTitle = navBar.staticTexts[Titles.firstViewControllerTitle]
        XCTAssert(navItemTitle.exists,
                  getErrorMessage(type: "Navigation Item title",
                                  identifier: "\(Titles.firstViewControllerTitle)")
        )
    }
}
