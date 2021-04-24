//
//  MockServer.swift
//  Test Assigment UI Automation
//
//  Created by Sai Kishore on 23/04/21.
//

import Foundation
import Reachability

class MockServer {
    // Single Instance throughout the code
    static let sharedInstance = MockServer()
    
    // Makes sure it cannot be initialised elsewhere
    private init() {}
    
    // Generates a mock data and returns after 3 seconds
    func loadDataFromServer(completion : @escaping ( Bool, [Item], Error?) -> ()) {
        let threeSecondsDelay: DispatchTime = .now() + 3
        DispatchQueue.main.asyncAfter(
            deadline: threeSecondsDelay,
            execute: {
                let items = self.generateRandomData(ofSize: 100)
                completion(true,items,nil)
            }
        )
    }
    
    // Generates Item data for given size
    func generateRandomData(ofSize size: Int) -> [Item] {
        var items = [Item]()
        let totalNumberOfItems = size as Int
        // Exit Condition
        if totalNumberOfItems <= 0 { return items }
        let redCellIndex = Int.random(in: 0..<totalNumberOfItems)
        for index in 0..<totalNumberOfItems {
            let item: Item
            if index == redCellIndex {
                item = Item(backgroundColor: .red, index: index)
            } else {
                item = Item(backgroundColor: .green, index: index)
            }
            items.append(item)
        }
        return items
    }
}
