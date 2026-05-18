//
//  JomloLayoutFactory.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A factory providing common compositional layout sections.
///
/// These are ready-to-use layout configurations inspired by streaming-app patterns:
/// hero banners, horizontal shelves, grids, and lists.
@MainActor
public enum JomloLayoutFactory {

    // MARK: - Hero / Feature

    /// A full-width hero section with optional paging behavior.
    ///
    /// - Parameters:
    ///   - height: The height of the hero section.
    ///   - isPaging: Whether the section pages between items.
    ///   - interItemSpacing: Spacing between items.
    /// - Returns: A configured layout section.
    public static func hero(
        height: NSCollectionLayoutDimension = .fractionalWidth(0.56),
        isPaging: Bool = true,
        interItemSpacing: CGFloat = 0
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.92),
            heightDimension: height
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = isPaging ? .groupPagingCentered : .continuous
        section.interGroupSpacing = interItemSpacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        return section
    }

    // MARK: - Horizontal Shelf

    /// A horizontally scrolling shelf of items (e.g., movie posters, show cards).
    ///
    /// - Parameters:
    ///   - itemWidth: The width of each item.
    ///   - itemHeight: The height of each item.
    ///   - interItemSpacing: Spacing between items.
    ///   - sectionInsets: Insets around the section.
    ///   - scrollBehavior: The orthogonal scrolling behavior.
    ///   - headerHeight: Optional header height (pass nil for no header).
    /// - Returns: A configured layout section.
    public static func horizontalShelf(
        itemWidth: NSCollectionLayoutDimension = .absolute(140),
        itemHeight: NSCollectionLayoutDimension = .absolute(200),
        interItemSpacing: CGFloat = 12,
        sectionInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16),
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous,
        headerHeight: NSCollectionLayoutDimension? = .estimated(44)
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: itemWidth,
            heightDimension: itemHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = scrollBehavior
        section.interGroupSpacing = interItemSpacing
        section.contentInsets = sectionInsets

        if let headerHeight {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: headerHeight
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    // MARK: - Grid

    /// A grid layout with a configurable number of columns.
    ///
    /// - Parameters:
    ///   - columns: Number of columns in the grid.
    ///   - itemHeight: The height of each item.
    ///   - interItemSpacing: Spacing between items (both horizontal and vertical).
    ///   - sectionInsets: Insets around the section.
    ///   - headerHeight: Optional header height.
    /// - Returns: A configured layout section.
    public static func grid(
        columns: Int = 2,
        itemHeight: NSCollectionLayoutDimension = .fractionalWidth(0.5),
        interItemSpacing: CGFloat = 12,
        sectionInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16),
        headerHeight: NSCollectionLayoutDimension? = .estimated(44)
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: itemHeight
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: interItemSpacing / 2,
            bottom: interItemSpacing,
            trailing: interItemSpacing / 2
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: itemHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets

        if let headerHeight {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: headerHeight
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    // MARK: - List

    /// A vertical list layout (single column, full width).
    ///
    /// - Parameters:
    ///   - rowHeight: The height of each row.
    ///   - interItemSpacing: Spacing between rows.
    ///   - sectionInsets: Insets around the section.
    ///   - headerHeight: Optional header height.
    /// - Returns: A configured layout section.
    public static func list(
        rowHeight: NSCollectionLayoutDimension = .estimated(60),
        interItemSpacing: CGFloat = 1,
        sectionInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16),
        headerHeight: NSCollectionLayoutDimension? = .estimated(44)
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: rowHeight
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: rowHeight
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interItemSpacing
        section.contentInsets = sectionInsets

        if let headerHeight {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: headerHeight
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    // MARK: - Wide Banner

    /// A full-width banner section (e.g., for promotions or announcements).
    ///
    /// - Parameters:
    ///   - height: The banner height.
    ///   - sectionInsets: Insets around the section.
    /// - Returns: A configured layout section.
    public static func banner(
        height: NSCollectionLayoutDimension = .absolute(120),
        sectionInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16)
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: height
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        return section
    }
}
