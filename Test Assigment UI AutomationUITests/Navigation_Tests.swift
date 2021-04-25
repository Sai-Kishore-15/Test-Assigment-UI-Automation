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
    
    func test_validateSecondViewController() {
        // taps each cell and checks information in its second view controller
        let app = XCUIApplication()
        var currentCellIndex = 0
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let navBarIdentifier = AccessibilityIdentifiers.navBarFirstViewController
        let collectionView = app.collectionViews[collectionViewIdentifier]
        let navigationBar = app.navigationBars[navBarIdentifier]
        let yesButton = app.alerts.element.buttons["Yes"]
        let backButton = navigationBar.buttons.element(boundBy: 0)
        var previousLastCellLabel = "defaultPreviousLabel"
        var lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
        XCTAssertNotEqual(lastCellLabel, "",
                          "You have not assigned accessibility labels to cells")
        // MARK:- Taps on each cell and validates the second vc title and background
        while (lastCellLabel != previousLastCellLabel ){
            let cell = collectionView.cells
                .containing(NSPredicate(format: "label ENDSWITH '\(currentCellIndex)'"))
            if cell.element.isHittable {
                let title = cell.element.label.components(separatedBy: " ").first
                XCTAssertNotEqual("", String(title!),
                                  "Title isnt set for \(currentCellIndex) cell")
                cell.element.tap()
                XCTAssertTrue(yesButton.exists,
                              "Yes button does not exist for \(currentCellIndex) cell")
                yesButton.tap()
                // Title = Green or Red
                let correctTitle = navigationBar.staticTexts[String(title!)]
                expectation(for: NSPredicate(format: "exists == 1"),
                            evaluatedWith: correctTitle, handler: nil)
                waitForExpectations(timeout: 2) { _ in
                    print(getErrorMessage(type: " Navigation Title ",
                                    identifier: "\(currentCellIndex)",
                                    inversePredicate: "does not contain \(String(describing: title))")
                    )
                }
                // Validate the background of the superView with its identifier.
                let backgroundColor = app.otherElements["\(title!)-second-view-controller"]
                XCTAssert(backgroundColor.exists)
                backButton.tap()
                previousLastCellLabel = "defaultPreviousLabel"
                lastCellLabel = "defaultLastCellLabel"
                currentCellIndex += 1
            }else {
                collectionView.swipeUp()
                let lastCell = collectionView.cells
                    .allElementsBoundByIndex.last
                XCTAssert(lastCell!.exists)
                if lastCell!.isHittable{
                    // Edge case, if its not hittable then it will not go to last cell.
                    previousLastCellLabel = lastCellLabel
                    lastCellLabel = lastCell!.label
                }
            }
        }
    }
}
