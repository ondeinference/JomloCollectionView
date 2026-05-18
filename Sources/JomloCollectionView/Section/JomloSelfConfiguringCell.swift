//
//  JomloSelfConfiguringCell.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A protocol for cells that can configure themselves given an item.
///
/// This is the UICollectionView equivalent of JomloTableView's `populateView(cell:)` pattern,
/// but type-safe and inverted — the cell knows how to configure itself.
@MainActor
public protocol JomloSelfConfiguringCell: UICollectionViewCell {

    /// The type of item this cell can display.
    associatedtype Item: JomloItem

    /// Configures the cell with the given item.
    ///
    /// - Parameter item: The item containing the data to display.
    func configure(with item: Item)
}
