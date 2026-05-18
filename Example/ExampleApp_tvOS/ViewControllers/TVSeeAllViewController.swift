//
//  TVSeeAllViewController.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A tvOS view controller that simulates loading content from a network request,
/// then displays the results in a grid optimized for the big screen.
///
/// Inspired by Viaplay's `LinkLoadingViewController` — shows a loading state
/// while "fetching" page data, then transitions to a focusable content grid.
@MainActor
final class TVSeeAllViewController: JomloCollectionViewController {

    private let sectionTitle: String
    private let contentItems: [TVContentItem]

    private lazy var loadingView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Loading..."
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(spinner)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -20),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 20),
        ])

        return container
    }()

    init(title: String, items: [TVContentItem]) {
        self.sectionTitle = title
        self.contentItems = items
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sectionTitle
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)

        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true

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
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.5))
            showContent()
        }
    }

    private func showContent() {
        loadingView.removeFromSuperview()
        collectionView.isHidden = false

        let gridSection = TVSeeAllGridSection(items: contentItems)
        setSections([gridSection], animated: true)
    }
}

// MARK: - Grid Section for tvOS "See All" page

@MainActor
private final class TVSeeAllGridSection: JomloSection {

    let identifier = JomloSectionID("tv-see-all-grid")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let gridItems: [TVContentItem]

    init(items: [TVContentItem]) {
        self.gridItems = items
    }

    func items() -> [any JomloItem] {
        gridItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        // 4 columns on TV for a nice grid
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .absolute(420)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(420)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 40, leading: 60, bottom: 40, trailing: 60)
        return section
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let contentItem = item as? TVContentItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(TVPosterCell.self, for: indexPath, item: contentItem)
    }
}
