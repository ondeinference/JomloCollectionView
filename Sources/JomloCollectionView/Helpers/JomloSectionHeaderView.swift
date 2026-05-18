//
//  JomloSectionHeaderView.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A reusable section header view with a title label and optional action button.
///
/// Register this with your collection view for section headers:
/// ```swift
/// collectionView.register(
///     JomloSectionHeaderView.self,
///     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
///     withReuseIdentifier: JomloSectionHeaderView.reuseIdentifier
/// )
/// ```
@MainActor
open class JomloSectionHeaderView: UICollectionReusableView {

    /// The reuse identifier for this header view.
    public static let reuseIdentifier = "JomloSectionHeaderView"

    /// The title label.
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityTraits = .header
        return label
    }()

    /// An optional action button (e.g., "See All").
    public let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.isHidden = true
        return button
    }()

    /// Callback when the action button is tapped.
    public var onActionTapped: (@MainActor @Sendable () -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }

    /// Configures the header with a title and optional action.
    ///
    /// - Parameters:
    ///   - title: The section title.
    ///   - actionTitle: Optional action button title. Pass nil to hide the button.
    ///   - action: Callback when the action button is tapped.
    public func configure(
        title: String,
        actionTitle: String? = nil,
        action: (@MainActor @Sendable () -> Void)? = nil
    ) {
        titleLabel.text = title
        if let actionTitle {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.isHidden = false
            onActionTapped = action
        } else {
            actionButton.isHidden = true
            onActionTapped = nil
        }
    }

    private func setupViews() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, actionButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc private func actionButtonTapped() {
        onActionTapped?()
    }
}
