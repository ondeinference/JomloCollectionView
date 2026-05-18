//
//  TVShelfSection.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A horizontal shelf of poster cards sized for TV viewing distance,
/// with a "See All" card appended as the final item in the shelf.
///
/// The last item renders as `TVSeeAllCell` — a dark card with a prompt
/// and pink pill button, matching the Viaplay tvOS design.
@MainActor
final class TVShelfSection: JomloSection {

    let identifier: JomloSectionID
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let title: String
    private let contentItems: [TVContentItem]
    weak var presenter: UIViewController?

    init(id: String, title: String, items: [TVContentItem], presenter: UIViewController? = nil) {
        self.identifier = JomloSectionID(id)
        self.title = title
        self.contentItems = items
        self.presenter = presenter
    }

    // MARK: - JomloSection

    /// Returns content items followed by a single `TVSeeAllItem` sentinel.
    func items() -> [any JomloItem] {
        let seeAll = TVSeeAllItem(id: "\(identifier.rawValue)-see-all", sectionTitle: title)
        return contentItems + [seeAll]
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
            widthDimension: .absolute(240),
            heightDimension: .absolute(420)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 40
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
        if let seeAllItem = item as? TVSeeAllItem {
            return collectionView.dequeueJomloCell(
                TVSeeAllCell.self, for: indexPath, item: seeAllItem)
        }
        guard let contentItem = item as? TVContentItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(TVPosterCell.self, for: indexPath, item: contentItem)
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
        // Title only — "See All" is now the last shelf card, not the header
        header.configure(title: title)
        return header
    }

    func didSelectItem(_ item: any JomloItem, at indexPath: IndexPath) {
        if let seeAllItem = item as? TVSeeAllItem {
            let seeAllVC = TVSeeAllViewController(
                title: seeAllItem.sectionTitle, items: contentItems)
            presenter?.navigationController?.pushViewController(seeAllVC, animated: true)
            return
        }
        if let contentItem = item as? TVContentItem {
            print("[tvOS] Selected: \(contentItem.title)")
        }
    }
}
