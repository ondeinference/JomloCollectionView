//
//  TVSectionHeaderView.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A section header designed for TV — large, bold title with an optional focusable "See All" button.
///
/// On tvOS, the "See All" button is a proper `UIButton` that participates in the
/// focus engine. It receives the standard tvOS focus styling automatically.
final class TVSectionHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "TVSectionHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .medium)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        button.isHidden = true
        // tvOS focus engine will automatically apply a scale + shadow on focus
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()

    private var onSeeAllTapped: (@MainActor @Sendable () -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    /// Configures the header.
    ///
    /// - Parameters:
    ///   - title: The section title.
    ///   - action: Optional closure called when "See All" is selected. Pass `nil` to hide the button.
    func configure(title: String, action: (@MainActor @Sendable () -> Void)? = nil) {
        titleLabel.text = title
        if let action {
            onSeeAllTapped = action
            seeAllButton.isHidden = false
        } else {
            onSeeAllTapped = nil
            seeAllButton.isHidden = true
        }
    }

    private func setupViews() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, UIView(), seeAllButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        seeAllButton.addTarget(self, action: #selector(seeAllPressed), for: .primaryActionTriggered)
    }

    @objc private func seeAllPressed() {
        onSeeAllTapped?()
    }
}
