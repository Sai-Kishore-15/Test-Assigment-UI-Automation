//
//  First_View_Controller_Tests.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 23/04/21.
//

import XCTest

class First_View_Controller_Collection_View_Tests: XCTestCase {

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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_isRedCellPresent() {
        // MARK:- Properties
        let app = XCUIApplication()
        var currentCellIndex = 0
        var isRedCellPresent = false
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let collectionView = app.collectionViews[collectionViewIdentifier]
        var previousLastCellLabel = "defaultPreviousLabel"
        var lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
        XCTAssertNotEqual(lastCellLabel, "",
                          "You have not assigned accessibility labels to cells")
        // MARK:- checks each cell for a red cell
        while (lastCellLabel != previousLastCellLabel ){
            let cell = collectionView.cells
                .containing(NSPredicate(format: "label ENDSWITH '\(currentCellIndex)'"))
            if cell.element.isHittable {
                let redCell = cell.containing(NSPredicate(format: "label BEGINSWITH 'Red'"))
                if redCell.element.exists {
                    isRedCellPresent = redCell.element.exists
                    break
                }
                currentCellIndex += 1
            }else {
                collectionView.swipeUp()
                previousLastCellLabel = lastCellLabel
                lastCellLabel = collectionView.cells
                    .allElementsBoundByIndex.last!.label
            }
        }
        XCTAssert(isRedCellPresent, "Could not find Red Cell")
    }

    func test_isOnlyOneRedCellPresent() {
        // MARK:- Properties
        let app = XCUIApplication()
        var currentCellIndex = 0
        var redCellCount = 0
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let collectionView = app.collectionViews[collectionViewIdentifier]
        var previousLastCellLabel = "defaultPreviousLabel"
        var lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
        XCTAssertNotEqual(lastCellLabel, "",
                          "You have not assigned accessibility labels to cells")
        // MARK:- Checks each cell for a red cell
        while (lastCellLabel != previousLastCellLabel ){
            let cell = collectionView.cells
                .containing(NSPredicate(format: "label ENDSWITH '\(currentCellIndex)'"))
            if cell.element.isHittable {
                let redCell = cell.containing(NSPredicate(format: "label BEGINSWITH 'Red'"))
                if redCell.element.exists {
                    redCellCount += 1
                }
                currentCellIndex += 1
            }else {
                collectionView.swipeUp()
                previousLastCellLabel = lastCellLabel
                lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
            }
        }
        XCTAssertEqual(1, redCellCount)
    }
}