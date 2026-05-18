//
//  SeeAllViewController.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A view controller that simulates loading content from a network request,
/// then displays the results in a grid layout.
///
/// Inspired by Viaplay's `LinkLoadingViewController` pattern — shows a loading
/// indicator while fetching page data, then transitions to a content grid.
@MainActor
final class SeeAllViewController: JomloCollectionViewController {

    private let sectionTitle: String
    private let contentItems: [PosterItem]

    private lazy var loadingView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Loading..."
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(spinner)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -16),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 12),
        ])

        return container
    }()

    init(title: String, items: [PosterItem]) {
        self.sectionTitle = title
        self.contentItems = items
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sectionTitle
        view.backgroundColor = .systemBackground

        collectionView.registerJomloCell(PosterCell.self)
        collectionView.register(
            JomloSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: JomloSectionHeaderView.reuseIdentifier
        )

        showLoading()
        simulateNetworkRequest()
    }

    private func showLoading() {
        collectionView.isHidden = true
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func simulateNetworkRequest() {
        // Simulate a 1.5 second network delay, then show content
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.5))
            showContent()
        }
    }

    private func showContent() {
        loadingView.removeFromSuperview()
        collectionView.isHidden = false

        // Display all items in a grid layout
        let gridSection = SeeAllGridSection(
            title: sectionTitle,
            items: contentItems
        )
        setSections([gridSection], animated: true)
    }
}

// MARK: - Grid Section for "See All" page

@MainActor
private final class SeeAllGridSection: JomloSection {

    let identifier: JomloSectionID
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let title: String
    private let gridItems: [PosterItem]

    init(title: String, items: [PosterItem]) {
        self.identifier = JomloSectionID("see-all-grid")
        self.title = title
        self.gridItems = items
    }

    func items() -> [any JomloItem] {
        gridItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        let columns = environment.container.contentSize.width > 500 ? 4 : 3
        return JomloLayoutFactory.grid(
            columns: columns,
            itemHeight: .absolute(220),
            interItemSpacing: 12,
            headerHeight: nil
        )
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let posterItem = item as? PosterItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(PosterCell.self, for: indexPath, item: posterItem)
    }

    var displayAnimation: JomloAnimator.Animation? {
        JomloAnimator.moveUpWithFade(offset: 20, duration: 0.4, delayFactor: 0.03)
    }
}
