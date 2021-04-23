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
        // does collection view with given identifier exist ?
        let collectionView = app.collectionViews[AccessibilityIdentifiers.collectionView]
        XCTAssertTrue(collectionView.exists,
                      getErrorMessage(type: "Collection View",
                                      identifier: "\(AccessibilityIdentifiers.collectionView)"))
        // is Collection view cell count > 0 ?
        let collectionViewCells = collectionView.cells
        expectation(for: NSPredicate(format: "count > 0"),
                    evaluatedWith: collectionViewCells,
                    handler: nil)
        waitForExpectations(timeout: 5, handler: { _ in
            print(self.getErrorMessage(type: "Collection view",
                                       identifier: "\(AccessibilityIdentifiers.collectionView)",
                                       inversePredicate: "- cell count is less than 0"))
        })
    }
    
    func test_validateTitle(){
        let app = XCUIApplication()
        app.launch()
        // does navigation bar with given identifier exist?
        let navBar = app.navigationBars[AccessibilityIdentifiers.navBarFirstViewController]
        XCTAssertTrue(navBar.exists,
                      getErrorMessage(type: "Navigation Bar",
                                      identifier: "\(AccessibilityIdentifiers.navBarFirstViewController)")
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
    }
    
    func test_isOnlyOneRedCellPresent() {
        // Checks if there's only one red cell presented in the View Controller
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
