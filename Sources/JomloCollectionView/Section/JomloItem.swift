//
//  JomloItem.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A protocol for items (view models) within a `JomloSection`.
///
/// Each item represents a single cell's data and knows how to configure its cell.
/// Items must be `Hashable` for diffable data source compatibility and `Sendable`
/// for Swift 6 concurrency safety.
@MainActor
public protocol JomloItem: Hashable, Sendable {

    /// A unique string identifier for this item, used for diffing.
    /// Must be nonisolated so it can be used in Hashable/Equatable conformances.
    nonisolated var itemIdentifier: String { get }
}

/// A type-erased wrapper around `JomloItem` for use in heterogeneous collections.
///
/// This wrapper captures the item's identifier at initialization time to allow
/// nonisolated access for Hashable/Equatable conformance required by diffable data sources.
public struct AnyJomloItem: Hashable, Sendable {

    @MainActor
    public let base: any JomloItem

    private let _itemIdentifier: String

    @MainActor
    public init(_ item: some JomloItem) {
        self.base = item
        self._itemIdentifier = item.itemIdentifier
    }

    /// The item identifier, accessible from any context.
    public var itemIdentifier: String { _itemIdentifier }

    public static func == (lhs: AnyJomloItem, rhs: AnyJomloItem) -> Bool {
        lhs._itemIdentifier == rhs._itemIdentifier
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_itemIdentifier)
    }
}
