//
//  ContinueWatchingSection.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

@MainActor
final class ContinueWatchingSection: JomloSection {

    let identifier = JomloSectionID("continue-watching")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let watchingItems: [ContinueWatchingItem]

    init(items: [ContinueWatchingItem]) {
        self.watchingItems = items
    }

    func items() -> [any JomloItem] {
        watchingItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        JomloLayoutFactory.horizontalShelf(
            itemWidth: .absolute(200),
            itemHeight: .absolute(170),
            interItemSpacing: 12,
            headerHeight: .estimated(44)
        )
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let watchingItem = item as? ContinueWatchingItem else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueJomloCell(
            ContinueWatchingCell.self, for: indexPath, item: watchingItem)
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
        header.configure(title: "Continue Watching")
        return header
    }

    var displayAnimation: JomloAnimator.Animation? {
        JomloAnimator.moveUpWithFade(offset: 20, duration: 0.4, delayFactor: 0.08)
    }
}
