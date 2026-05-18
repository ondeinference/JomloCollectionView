//
//  TVCategoryCell.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A large category tile for TV navigation grids.
/// Features prominent icon + label with focus scaling and color highlight.
final class TVCategoryCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 52)
        label.textAlignment = .center
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
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

    func configure(with item: TVCategoryItem) {
        iconLabel.text = item.icon
        nameLabel.text = item.name
        contentView.backgroundColor = UIColor(hex: item.colorHex) ?? .darkGray
    }

    // MARK: - Focus Engine

    override var canBecomeFocused: Bool { true }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator
    ) {
        coordinator.addCoordinatedAnimations(
            {
                if self.isFocused {
                    self.transform = CGAffineTransform(scaleX: 1.06, y: 1.06)
                    self.contentView.layer.borderColor = UIColor.white.cgColor
                    self.contentView.layer.borderWidth = 4
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.6
                    self.layer.shadowRadius = 12
                    self.layer.shadowOffset = CGSize(width: 0, height: 10)
                } else {
                    self.transform = .identity
                    self.contentView.layer.borderWidth = 0
                    self.layer.shadowOpacity = 0
                }
            }, completion: nil)
    }

    private func setupViews() {
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true
        clipsToBounds = false

        let stack = UIStackView(arrangedSubviews: [iconLabel, nameLabel])
        stack.axis = .vertical
        stack.spacing = 10
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
