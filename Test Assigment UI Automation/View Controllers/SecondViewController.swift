//
//  SecondViewController.swift
//  Test Assigment UI Automation
//
//  Created by Alexios on 12/4/21.
//

import UIKit

final class SecondViewController: UIViewController {
    // MARK: - Properties
    private var customTitle: String?
    private var customBackgroundColor: UIColor?

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = customTitle
        view.backgroundColor = customBackgroundColor
    }

    // MARK: - Public functions
    func configure(title: String, backgroundColor: UIColor) {
        customTitle = title
        customBackgroundColor = backgroundColor
    }
}
