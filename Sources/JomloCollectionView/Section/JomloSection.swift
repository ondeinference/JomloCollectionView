//
//  JomloSection.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A Sendable, Hashable wrapper for section identifiers.
///
/// This exists because `AnyHashable` does not conform to `Sendable` in Swift 6,
/// but `NSDiffableDataSourceSnapshot` requires its section identifier type to be `Sendable`.
public struct JomloSectionID: Hashable, Sendable {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

/// The core protocol that defines a section in a `JomloCollectionView`.
///
/// Each section is responsible for:
/// - Providing its items (view models)
/// - Defining its compositional layout
/// - Configuring cells for its items
/// - Handling item selection
///
/// Sections are composable building blocks — the same section type can render
/// differently based on configuration, following the style-driven reuse pattern.
@MainActor
public protocol JomloSection: AnyObject, Sendable {

    /// A unique, stable identifier for this section.
    var identifier: JomloSectionID { get }

    /// Returns the items for this section.
    ///
    /// Items must conform to `JomloItem` and be `Hashable` + `Sendable`.
    /// The diffable data source uses these to compute changes.
    func items() -> [any JomloItem]

    /// Creates the compositional layout for this section.
    ///
    /// - Parameters:
    ///   - environment: The layout environment providing trait and geometry info.
    ///   - sectionIndex: The index of this section in the collection view.
    /// - Returns: A fully configured `NSCollectionLayoutSection`.
    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection

    /// Provides a configured cell for the given item.
    ///
    /// - Parameters:
    ///   - item: The item to configure a cell for.
    ///   - collectionView: The parent collection view.
    ///   - indexPath: The index path for the cell.
    /// - Returns: A configured `UICollectionViewCell`.
    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell

    /// Called when an item in this section is selected.
    ///
    /// - Parameters:
    ///   - item: The selected item.
    ///   - indexPath: The index path of the selected item.
    func didSelectItem(_ item: any JomloItem, at indexPath: IndexPath)

    /// Optional supplementary view provider for this section.
    ///
    /// - Parameters:
    ///   - kind: The supplementary view kind (e.g., header, footer).
    ///   - collectionView: The parent collection view.
    ///   - indexPath: The index path for the supplementary view.
    /// - Returns: A configured supplementary view, or `nil`.
    func supplementaryView(
        ofKind kind: String,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionReusableView?

    /// Called when the section should prefetch upcoming content.
    func prefetchIfNeeded()

    /// Optional display animation for cells in this section.
    var displayAnimation: JomloAnimator.Animation? { get }

    /// A callback invoked when this section needs to reload its data.
    /// Set by the collection view controller.
    var onReloadNeeded: (@MainActor @Sendable () -> Void)? { get set }
}

// MARK: - Default Implementations

extension JomloSection {

    public func didSelectItem(_ item: any JomloItem, at indexPath: IndexPath) {}

    public func supplementaryView(
        ofKind kind: String,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionReusableView? {
        nil
    }

    public func prefetchIfNeeded() {}

    public var displayAnimation: JomloAnimator.Animation? { nil }
}
