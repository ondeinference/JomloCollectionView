//
//  CategoryCell.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

final class CategoryCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    func configure(with item: CategoryItem) {
        iconLabel.text = item.iconName
        nameLabel.text = item.name
        contentView.backgroundColor = UIColor(hex: item.colorHex) ?? .systemGray
    }

    private func setupViews() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        let stack = UIStackView(arrangedSubviews: [iconLabel, nameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { nameLabel.text }
        set {}
    }
}
