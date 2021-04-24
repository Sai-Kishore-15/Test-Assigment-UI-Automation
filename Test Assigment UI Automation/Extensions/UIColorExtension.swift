//
//  UIColorExtension.swift
//  Test Assigment UI Automation
//
//  Created by Sai Kishore on 24/04/21.
//

import Foundation
import UIKit

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.black: return "Black"
        case UIColor.darkGray: return "DarkGray"
        case UIColor.lightGray: return "LightGray"
        case UIColor.white: return "White"
        case UIColor.gray: return "Gray"
        case UIColor.red: return "Red"
        case UIColor.green: return "Green"
        case UIColor.blue: return "Blue"
        case UIColor.cyan: return "Cyan"
        case UIColor.yellow: return "Yellow"
        case UIColor.magenta: return "Magenta"
        case UIColor.orange: return "Orange"
        case UIColor.purple: return "Purple"
        case UIColor.brown: return "Brown"
        default: return nil
        }
    }
}
