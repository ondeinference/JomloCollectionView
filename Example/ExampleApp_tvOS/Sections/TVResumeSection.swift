//
//  TVResumeSection.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// A "Continue Watching" shelf with wide landscape cards showing progress.
@MainActor
final class TVResumeSection: JomloSection {

    let identifier = JomloSectionID("tv-resume")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let resumeItems: [TVResumeItem]

    init(items: [TVResumeItem]) {
        self.resumeItems = items
    }

    func items() -> [any JomloItem] {
        resumeItems
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        // Wide landscape cards — 16:9 thumbnails
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(380),
            heightDimension: .absolute(320)
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
        guard let resumeItem = item as? TVResumeItem else { return UICollectionViewCell() }
        return collectionView.dequeueJomloCell(TVResumeCell.self, for: indexPath, item: resumeItem)
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
        header.configure(title: "Continue Watching")
        return header
    }
}
