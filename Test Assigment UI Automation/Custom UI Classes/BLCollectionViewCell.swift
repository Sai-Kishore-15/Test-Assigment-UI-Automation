//
//  BLCollectionViewCell.swift
//  Test Assigment UI Automation
//
//  Created by Sai Kishore on 22/04/21.
//

import Foundation
import UIKit

final class BLCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let titleLabel = UILabel(frame: .zero)
    static let reuseIdentifierDefault = defaultReuseIdentifier

    // MARK: - UICollectionViewCell
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.green

        // create a title lable
        titleLabel.text = "Normal Cell"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        // configure title lable layout
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleMargin = 16 as CGFloat
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: titleMargin),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: titleMargin),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(index: Int, title: String, backgroundColor: UIColor){
        self.titleLabel.text = "\(title) Cell at index \(index)"
        self.backgroundColor = backgroundColor
        self.accessibilityIdentifier = "\(title)_\(index)"
        self.accessibilityLabel = self.titleLabel.text
    }
}
// MARK:- PRIVATE EXTENSIONS
private extension UICollectionViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
