//
//  TVHeroCell.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A large hero cell for the top-shelf-style featured content area.
/// Designed for 1920x1080 TV screens with generous padding and large typography.
final class TVHeroCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let gradientLayer = CAGradientLayer()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 56, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        label.numberOfLines = 1
        return label
    }()

    private let metadataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        return label
    }()

    private let focusOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        view.layer.cornerRadius = 24
        view.alpha = 0
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }

    func configure(with item: TVHeroItem) {
        titleLabel.text = item.title
        taglineLabel.text = item.tagline
        metadataLabel.text = item.metadata

        let topColor = UIColor(hex: item.gradientTop) ?? .darkGray
        let bottomColor = UIColor(hex: item.gradientBottom) ?? .black
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }

    // MARK: - Focus Engine

    override var canBecomeFocused: Bool { true }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator
    ) {
        coordinator.addCoordinatedAnimations(
            {
                if self.isFocused {
                    self.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                    self.focusOverlay.alpha = 1
                    self.layer.shadowColor = UIColor.white.cgColor
                    self.layer.shadowOpacity = 0.3
                    self.layer.shadowRadius = 20
                    self.layer.shadowOffset = CGSize(width: 0, height: 10)
                } else {
                    self.transform = .identity
                    self.focusOverlay.alpha = 0
                    self.layer.shadowOpacity = 0
                }
            }, completion: nil)
    }

    private func setupViews() {
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        clipsToBounds = false
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        focusOverlay.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(focusOverlay)

        let textStack = UIStackView(arrangedSubviews: [titleLabel, taglineLabel, metadataLabel])
        textStack.axis = .vertical
        textStack.spacing = 12
        textStack.alignment = .leading
        textStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textStack)

        NSLayoutConstraint.activate([
            focusOverlay.topAnchor.constraint(equalTo: contentView.topAnchor),
            focusOverlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            focusOverlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            focusOverlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            textStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            textStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])

        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { "\(titleLabel.text ?? ""). \(taglineLabel.text ?? "")" }
        set {}
    }
}
