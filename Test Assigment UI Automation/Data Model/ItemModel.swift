//
//  Item model.swift
//  Test Assigment UI Automation
//
//  Created by Sai Kishore on 23/04/21.
//

import Foundation
import UIKit

struct Item {
    let backgroundColor: UIColor
    let index: Int
    let title: String
    init(backgroundColor: UIColor, index: Int, customTitle: String? = nil){
        self.backgroundColor = backgroundColor
        self.index = index
        self.title = customTitle != nil ? customTitle! :
            backgroundColor.name ?? defaultStaticTexts.colorUndefined
    }
}

