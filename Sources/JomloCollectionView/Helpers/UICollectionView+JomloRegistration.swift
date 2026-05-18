//
//  UICollectionView+JomloRegistration.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

extension UICollectionView {

    /// Registers a `JomloSelfConfiguringCell` for use with the collection view.
    ///
    /// - Parameter cellType: The cell class to register.
    public func registerJomloCell<T: JomloSelfConfiguringCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }

    /// Dequeues a registered `JomloSelfConfiguringCell` and configures it with the given item.
    ///
    /// - Parameters:
    ///   - cellType: The cell class to dequeue.
    ///   - indexPath: The index path to dequeue for.
    ///   - item: The item to configure the cell with.
    /// - Returns: A configured cell.
    public func dequeueJomloCell<T: JomloSelfConfiguringCell>(
        _ cellType: T.Type,
        for indexPath: IndexPath,
        item: T.Item
    ) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
        else {
            fatalError("Failed to dequeue cell of type \(cellType) with identifier \(identifier)")
        }
        cell.configure(with: item)
        return cell
    }
}
