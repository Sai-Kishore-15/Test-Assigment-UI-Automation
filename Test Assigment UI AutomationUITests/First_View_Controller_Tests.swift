//
//  First_View_Controller_Tests.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 23/04/21.
//

import XCTest

class First_View_Controller_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_didPopulateCollectionView() {
        let app = XCUIApplication()
        app.launch()
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        // does collection view with given identifier exist ?
        let collectionView = app.collectionViews[collectionViewIdentifier]
        XCTAssertTrue(collectionView.exists,
                      getErrorMessage(type: "Collection View",
                                      identifier: "\(collectionViewIdentifier)"))
        // is Collection view cell count > 0 ?
        let collectionViewCells = collectionView.cells
        expectation(for: NSPredicate(format: "count > 0"),
                    evaluatedWith: collectionViewCells,
                    handler: nil)
        waitForExpectations(timeout: 5, handler: { _ in
            print(self.getErrorMessage(type: "Collection view",
                                       identifier: "\(collectionViewIdentifier)",
                                       inversePredicate: "- cell count is less than 0"))
        })
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
    
    func test_isRedCellPresent() {
        // Checks if red cell is present in the View Controller
        let app = XCUIApplication()
        app.launch()
        // MARK:- Properties
        var currentCellIndex = 0
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let collectionView = app.collectionViews[collectionViewIdentifier]
        var isRedCellPresent = false
        
        //MARK:- Waits for Cells
        expectation(for: NSPredicate(format: "count > 0"),
                    evaluatedWith: collectionView.cells)
        waitForExpectations(timeout: 5, handler: {_ in
            print(self.getErrorMessage(type: "Collection View",
                                       identifier: "\(collectionViewIdentifier)")
            )
        })
        // MARK:- Checks each cell for a red cell
        var previousLastCellLabel = "defaultPreviousLabel"
        var lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
        XCTAssertNotEqual(lastCellLabel, "",
                          "You have not assigned accessibility labels to cells")
        
        while (lastCellLabel != previousLastCellLabel ){
            let cell = collectionView.cells
                .containing(NSPredicate(format: "label ENDSWITH '\(currentCellIndex)'"))
            if cell.element.exists && cell.element.isHittable {
                let redCell = cell.containing(NSPredicate(format: "label BEGINSWITH 'Red'"))
                if redCell.element.exists {
                    isRedCellPresent = redCell.element.exists
                    break
                }
                currentCellIndex += 1
            }else {
                collectionView.swipeUp()
                previousLastCellLabel = lastCellLabel
                lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
            }
        }
        XCTAssert(isRedCellPresent, "Could not find Red Cell")
    }

    func test_isOnlyOneRedCellPresent() {
        // Checks if there's only one red cell presented in the View Controller
        let app = XCUIApplication()
        app.launch()
        // MARK:- Properties
        var currentCellIndex = 0
        let collectionViewIdentifier = AccessibilityIdentifiers.collectionView
        let collectionView = app.collectionViews[collectionViewIdentifier]
        var redCellCount = 0
        
        //MARK:- Waits for Cells
        expectation(for: NSPredicate(format: "count > 0"),
                    evaluatedWith: collectionView.cells)
        waitForExpectations(timeout: 5, handler: {_ in
            print(self.getErrorMessage(type: "Collection View",
                                       identifier: "\(collectionViewIdentifier)")
            )
        })
        // MARK:- Checks each cell for a red cell
        var previousLastCellLabel = "defaultPreviousLabel"
        var lastCellLabel = collectionView.cells.allElementsBoundByIndex.last!.label
        XCTAssertNotEqual(lastCellLabel, "",
                          "You have not assigned accessibility labels to cells")
        
        while (lastCellLabel != previousLastCellLabel ){
            let cell = collectionView.cells
                .containing(NSPredicate(format: "label ENDSWITH '\(currentCellIndex)'"))

            if cell.element.exists && cell.element.isHittable {
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
    
    // Print Message
    private func getErrorMessage(type: String,
                      identifier: String,
                      inversePredicate: String = "does not exist") -> String {
        return """
                \(type) with identifier \(identifier) \(inversePredicate)
            """
    }
}
