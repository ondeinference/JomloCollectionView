//
//  TVHeroSection.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A full-width hero section for featured content at the top of the TV screen.
/// Uses group paging for a cinematic browsing feel with the Siri Remote.
@MainActor
final class TVHeroSection: JomloSection {

    let identifier = JomloSectionID("tv-hero")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let heroItems: [TVHeroItem]

    init(items: [TVHeroItem]) {
        self.heroItems = items
    }

    func items() -> [any JomloItem] {
        heroItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        // Full-width hero sized for 1080p TV (16:9 ratio, padded)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .absolute(500)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 40
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20, leading: 0, bottom: 50, trailing: 0)
        return section
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let heroItem = item as? TVHeroItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(TVHeroCell.self, for: indexPath, item: heroItem)
    }
}
