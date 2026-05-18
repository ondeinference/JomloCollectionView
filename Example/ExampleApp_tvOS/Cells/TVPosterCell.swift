//
//  TVPosterCell.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A poster cell optimized for TV — large artwork area with focus-driven scaling
/// and shadow. Uses the tvOS focus engine for smooth parallax-like interactions.
final class TVPosterCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let posterView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
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

    func configure(with item: TVContentItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        posterView.backgroundColor = UIColor(hex: item.colorHex) ?? .darkGray
    }

    // MARK: - Focus Engine

    override var canBecomeFocused: Bool { true }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator
    ) {
        coordinator.addCoordinatedAnimations(
            {
                if self.isFocused {
                    self.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowRadius = 15
                    self.layer.shadowOffset = CGSize(width: 0, height: 15)
                    self.titleLabel.alpha = 1
                    self.subtitleLabel.alpha = 1
                } else {
                    self.transform = .identity
                    self.layer.shadowOpacity = 0
                    self.titleLabel.alpha = 0.8
                    self.subtitleLabel.alpha = 0.5
                }
            }, completion: nil)
    }

    private func setupViews() {
        clipsToBounds = false
        contentView.clipsToBounds = false

        let stack = UIStackView(arrangedSubviews: [posterView, titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            posterView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.5),
        ])

        titleLabel.alpha = 0.8
        subtitleLabel.alpha = 0.5

        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { "\(titleLabel.text ?? ""). \(subtitleLabel.text ?? "")" }
        set {}
    }
}
