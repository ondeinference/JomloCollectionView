//
//  CategoriesGridSection.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

@MainActor
final class CategoriesGridSection: JomloSection {

    let identifier = JomloSectionID("categories")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let categoryItems: [CategoryItem]

    init(items: [CategoryItem]) {
        self.categoryItems = items
    }

    func items() -> [any JomloItem] {
        categoryItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        let columns = environment.container.contentSize.width > 500 ? 4 : 2
        return JomloLayoutFactory.grid(
            columns: columns,
            itemHeight: .absolute(100),
            interItemSpacing: 12,
            headerHeight: .estimated(44)
        )
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let categoryItem = item as? CategoryItem else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueJomloCell(
            CategoryCell.self, for: indexPath, item: categoryItem)
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
                withReuseIdentifier: JomloSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? JomloSectionHeaderView
        else {
            return nil
        }
        header.configure(title: "Categories")
        return header
    }
}
