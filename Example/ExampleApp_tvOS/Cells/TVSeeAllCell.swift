//
//  TVSeeAllCell.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// The "See All" last-item card for tvOS shelves.
///
/// Matches the Viaplay design: dark semi-transparent background,
/// a prompt question, and a prominent pink pill button — all
/// the same height as a poster card so it sits flush in the shelf.
///
/// Focus behaviour mirrors `TVPosterCell`: scales up with a shadow lift.
final class TVSeeAllCell: UICollectionViewCell, JomloSelfConfiguringCell {

    // MARK: - Views

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you want to see more similar titles?"
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let pillButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        // Viaplay pink/magenta — #E8005A
        button.backgroundColor = UIColor(red: 0.91, green: 0.0, blue: 0.35, alpha: 1.0)
        button.layer.cornerRadius = 28
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
        // Disable interaction — the cell itself handles selection
        button.isUserInteractionEnabled = false
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    // MARK: - JomloSelfConfiguringCell

    func configure(with item: TVSeeAllItem) {
        // The layout is static — nothing to configure from the model
    }

    // MARK: - Focus Engine

    override var canBecomeFocused: Bool { true }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext,
        with coordinator: UIFocusAnimationCoordinator
    ) {
        coordinator.addCoordinatedAnimations(
            {
                if self.isFocused {
                    self.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.6
                    self.layer.shadowRadius = 20
                    self.layer.shadowOffset = CGSize(width: 0, height: 16)
                    // Brighten the pill on focus
                    self.pillButton.transform = CGAffineTransform(scaleX: 1.04, y: 1.04)
                } else {
                    self.transform = .identity
                    self.layer.shadowOpacity = 0
                    self.pillButton.transform = .identity
                }
            }, completion: nil)
    }

    // MARK: - Layout

    private func setupViews() {
        // Dark frosted-glass look — matches the screenshot
        contentView.backgroundColor = UIColor(white: 0.12, alpha: 1.0)
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
        clipsToBounds = false

        let stack = UIStackView(arrangedSubviews: [promptLabel, pillButton])
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])

        isAccessibilityElement = true
        accessibilityTraits = .button
        accessibilityLabel = "See all. Do you want to see more similar titles?"
    }
}
