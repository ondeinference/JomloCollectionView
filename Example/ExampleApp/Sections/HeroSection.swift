//
//  HeroSection.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

@MainActor
final class HeroSection: JomloSection {

    let identifier = JomloSectionID("hero")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let heroItems: [HeroItem]

    init(items: [HeroItem]) {
        self.heroItems = items
    }

    func items() -> [any JomloItem] {
        heroItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        JomloLayoutFactory.hero(
            height: .fractionalWidth(0.56),
            isPaging: true,
            interItemSpacing: 12
        )
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let heroItem = item as? HeroItem else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueJomloCell(HeroCell.self, for: indexPath, item: heroItem)
    }

    var displayAnimation: JomloAnimator.Animation? {
        JomloAnimator.scaleUp(initialScale: 0.9, duration: 0.5, delayFactor: 0.1)
    }
}
