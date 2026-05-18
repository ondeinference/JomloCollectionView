//
//  HeroCell.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

final class HeroCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.8)
        return label
    }()

    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("\u{25B6} Play", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = false
        return button
    }()

    private let gradientLayer = CAGradientLayer()

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

    func configure(with item: HeroItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        let topColor = UIColor(hex: item.gradientColors.top) ?? .systemBlue
        let bottomColor = UIColor(hex: item.gradientColors.bottom) ?? .systemIndigo
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }

    private func setupViews() {
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, playButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 36),
        ])

        // Accessibility
        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { titleLabel.text }
        set {}
    }
}
