//
//  TVCategorySection.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A horizontally scrolling row of large category tiles for TV navigation.
@MainActor
final class TVCategorySection: JomloSection {

    let identifier = JomloSectionID("tv-categories")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let categoryItems: [TVCategoryItem]

    init(items: [TVCategoryItem]) {
        self.categoryItems = items
    }

    func items() -> [any JomloItem] {
        categoryItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(280),
            heightDimension: .absolute(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 35
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 80, bottom: 50, trailing: 80)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let catItem = item as? TVCategoryItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(TVCategoryCell.self, for: indexPath, item: catItem)
    }

    func supplementaryView(
        ofKind kind: String,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionReusableView? {
        guard kind == UICollectionView.elementKindSectionHeader else { return nil }
        guard
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TVSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? TVSectionHeaderView
        else { return nil }
        header.configure(title: "Browse")
        return header
    }
}
