//
//  Navigation_Tests.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 24/04/21.
//

import XCTest

class Navigation_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        // Check if the application loads the collection view cells
        let app = XCUIApplication()
        app.launch()
        //MARK:- does collection view with given identifier exist?
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let collectionView = app.collectionViews[collectionViewIdentifier]
        XCTAssertTrue(collectionView.exists,
                      getErrorMessage(type: "Collection View",
                                      identifier: "\(collectionViewIdentifier)"))
        //MARK:- is Collection view cell count > 0 ?
        let collectionViewCells = collectionView.cells
        expectation(for: NSPredicate(format: "count > 0"),
                    evaluatedWith: collectionViewCells,
                    handler: nil)
        waitForExpectations(timeout: 5, handler: { _ in
            print(getErrorMessage(type: "Collection view",
                                       identifier: "\(collectionViewIdentifier)",
                                       inversePredicate: "- cell count is less than 0"))
        })
    }

    override func tearDownWithError() throws {
        // tearDown Functions here
    }
    
    func test_collectionViewScrollsToTop_whenBackButtonIsTapped(){
        //MARK:- Properties
        let app = XCUIApplication()
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let navBarIdentifier = AccessibilityIdentifiers.navBarFirstViewController
        let collectionView = app.collectionViews[collectionViewIdentifier]
        let navigationBar = app.navigationBars[navBarIdentifier]
        let yesButton = app.alerts.element.buttons["Yes"]
        let backButton = navigationBar.buttons.element(boundBy: 0)
        // MARK:- Actions and Assertions
        collectionView.cells.element.firstMatch.tap()
        XCTAssert(yesButton.exists,"Yes button does not exist")
        yesButton.tap()
        backButton.tap()
        XCTAssertTrue(collectionView.exists, "The button at index 0 is not 'back'")
        // MARK:- Collection view first cell position and full visibility
        let firstCell = collectionView.cells.allElementsBoundByIndex.first
        XCTAssert(firstCell!.exists)
        XCTAssert(firstCell!.label.hasSuffix("0"),"\(firstCell!.label) != 0")
        XCTAssert(app.windows.element(boundBy: 0).frame.contains(firstCell!.frame))
    }
    
    func test_validateSecondViewController(){
        
    }
}
