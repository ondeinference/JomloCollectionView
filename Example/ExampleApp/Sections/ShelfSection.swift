//
//  ShelfSection.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

@MainActor
final class ShelfSection: JomloSection {

    let identifier: JomloSectionID
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let title: String
    private let posterItems: [PosterItem]
    private let onItemSelected: (@MainActor (PosterItem) -> Void)?
    weak var presenter: UIViewController?

    init(
        id: String,
        title: String,
        items: [PosterItem],
        presenter: UIViewController? = nil,
        onItemSelected: (@MainActor (PosterItem) -> Void)? = nil
    ) {
        self.identifier = JomloSectionID(id)
        self.title = title
        self.posterItems = items
        self.presenter = presenter
        self.onItemSelected = onItemSelected
    }

    func items() -> [any JomloItem] {
        posterItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        JomloLayoutFactory.horizontalShelf(
            itemWidth: .absolute(140),
            itemHeight: .absolute(250),
            interItemSpacing: 12,
            headerHeight: .estimated(44)
        )
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let posterItem = item as? PosterItem else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueJomloCell(PosterCell.self, for: indexPath, item: posterItem)
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
        header.configure(title: title, actionTitle: "See All") { [weak self] in
            guard let self else { return }
            let seeAllVC = SeeAllViewController(title: self.title, items: self.posterItems)
            self.presenter?.navigationController?.pushViewController(seeAllVC, animated: true)
        }
        return header
    }

    func didSelectItem(_ item: any JomloItem, at indexPath: IndexPath) {
        guard let posterItem = item as? PosterItem else { return }
        onItemSelected?(posterItem)
    }

    var displayAnimation: JomloAnimator.Animation? {
        JomloAnimator.fadeIn(duration: 0.3, delayFactor: 0.05)
    }
}
