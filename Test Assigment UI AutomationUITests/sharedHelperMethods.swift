//
//  sharedHelperMethods.swift
//  Test Assigment UI AutomationUITests
//
//  Created by Sai Kishore on 24/04/21.
//

import Foundation

// Print Message
func getErrorMessage(type: String,
                  identifier: String,
                  inversePredicate: String = "does not exist") -> String {
    return """
            \(type) with identifier \(identifier) \(inversePredicate)
        """
}
