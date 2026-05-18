//
//  ContinueWatchingCell.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

final class ContinueWatchingCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let thumbnailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        return label
    }()

    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .darkGray
        progress.progressTintColor = .systemRed
        return progress
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    func configure(with item: ContinueWatchingItem) {
        titleLabel.text = item.title
        episodeLabel.text = item.episodeInfo
        progressView.progress = item.progress
        thumbnailView.backgroundColor = UIColor(hex: item.colorHex) ?? .gray
    }

    private func setupViews() {
        let textStack = UIStackView(arrangedSubviews: [titleLabel, episodeLabel])
        textStack.axis = .vertical
        textStack.spacing = 2

        let mainStack = UIStackView(arrangedSubviews: [thumbnailView, textStack, progressView])
        mainStack.axis = .vertical
        mainStack.spacing = 6
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            thumbnailView.heightAnchor.constraint(
                equalTo: thumbnailView.widthAnchor, multiplier: 0.56),
        ])

        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { "\(titleLabel.text ?? ""), \(episodeLabel.text ?? "")" }
        set {}
    }
}
