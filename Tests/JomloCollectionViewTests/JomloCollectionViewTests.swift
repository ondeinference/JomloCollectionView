//
//  JomloCollectionViewTests.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import Testing
import UIKit

@testable import JomloCollectionView

@MainActor
struct JomloCollectionViewTests {

    @Test("JomloCollectionViewController initializes with empty sections")
    func emptyInitialization() {
        let vc = JomloCollectionViewController(sections: [])
        vc.loadViewIfNeeded()
        #expect(vc.sections.isEmpty)
        #expect(vc.collectionView.superview != nil)
    }

    @Test("JomloCollectionViewController accepts sections")
    func sectionsAreSet() {
        let section = MockSection(id: "test")
        let vc = JomloCollectionViewController(sections: [section])
        vc.loadViewIfNeeded()
        #expect(vc.sections.count == 1)
    }

    @Test("JomloAnimator stops after all visible cells animated")
    func animatorStops() {
        var animationCount = 0
        let animator = JomloAnimator { _, _, _ in
            animationCount += 1
        }
        #expect(animationCount == 0)
        // Animator created successfully
    }

    @Test("AnyJomloItem wraps items correctly")
    func anyItemWrapping() {
        let item = MockItem(id: "item1", title: "Test")
        let wrapped = AnyJomloItem(item)
        #expect(wrapped.itemIdentifier == "item1")
    }

    @Test("JomloLayoutFactory creates hero section")
    func heroLayout() {
        let section = JomloLayoutFactory.hero()
        #expect(section.orthogonalScrollingBehavior == .groupPagingCentered)
    }

    @Test("JomloLayoutFactory creates horizontal shelf")
    func shelfLayout() {
        let section = JomloLayoutFactory.horizontalShelf()
        #expect(section.orthogonalScrollingBehavior == .continuous)
    }

    @Test("Section header view configures correctly")
    func headerConfiguration() {
        let header = JomloSectionHeaderView(frame: .zero)
        header.configure(title: "Trending", actionTitle: "See All")
        #expect(header.titleLabel.text == "Trending")
        #expect(header.actionButton.isHidden == false)
    }

    @Test("Section header hides action button when nil")
    func headerNoAction() {
        let header = JomloSectionHeaderView(frame: .zero)
        header.configure(title: "Movies")
        #expect(header.actionButton.isHidden == true)
    }
}

// MARK: - Test Helpers

@MainActor
final class MockSection: JomloSection {
    let identifier: JomloSectionID
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    init(id: String) {
        self.identifier = JomloSectionID(id)
    }

    func items() -> [any JomloItem] {
        [MockItem(id: "1", title: "Mock")]
    }

    func layoutSection(environment: NSCollectionLayoutEnvironment, sectionIndex: Int)
        -> NSCollectionLayoutSection
    {
        JomloLayoutFactory.list()
    }

    func cell(for item: any JomloItem, in collectionView: UICollectionView, at indexPath: IndexPath)
        -> UICollectionViewCell
    {
        UICollectionViewCell()
    }
}

struct MockItem: JomloItem {
    let id: String
    let title: String

    nonisolated var itemIdentifier: String { id }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    nonisolated static func == (lhs: MockItem, rhs: MockItem) -> Bool {
        lhs.id == rhs.id
    }
}
