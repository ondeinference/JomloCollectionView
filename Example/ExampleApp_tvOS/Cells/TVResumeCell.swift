//
//  TVResumeCell.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A "Continue Watching" cell for TV with large thumbnail, progress bar,
/// and remaining-time badge. Focus causes the cell to lift with shadow.
final class TVResumeCell: UICollectionViewCell, JomloSelfConfiguringCell {

    private let thumbnailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        return label
    }()

    private let remainingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()

    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.trackTintColor = UIColor.white.withAlphaComponent(0.2)
        pv.progressTintColor = .systemRed
        pv.layer.cornerRadius = 3
        pv.clipsToBounds = true
        return pv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    func configure(with item: TVResumeItem) {
        titleLabel.text = item.title
        episodeLabel.text = item.episodeInfo
        remainingLabel.text = item.remainingTime
        progressView.progress = item.progress
        thumbnailView.backgroundColor = UIColor(hex: item.colorHex) ?? .darkGray
    }

    // MARK: - Focus Engine

    override var canBecomeFocused: Bool { true }

    override func didUpdateFocus(
        in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator
    ) {
        coordinator.addCoordinatedAnimations(
            {
                if self.isFocused {
                    self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowRadius = 15
                    self.layer.shadowOffset = CGSize(width: 0, height: 12)
                } else {
                    self.transform = .identity
                    self.layer.shadowOpacity = 0
                }
            }, completion: nil)
    }

    private func setupViews() {
        clipsToBounds = false
        contentView.clipsToBounds = false

        let textStack = UIStackView(arrangedSubviews: [titleLabel, episodeLabel, remainingLabel])
        textStack.axis = .vertical
        textStack.spacing = 6

        let mainStack = UIStackView(arrangedSubviews: [thumbnailView, progressView, textStack])
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            thumbnailView.heightAnchor.constraint(
                equalTo: thumbnailView.widthAnchor, multiplier: 0.56),
            progressView.heightAnchor.constraint(equalToConstant: 6),
        ])

        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    override var accessibilityLabel: String? {
        get { "\(titleLabel.text ?? ""). \(episodeLabel.text ?? ""). \(remainingLabel.text ?? "")" }
        set {}
    }
}
