//
//  CategoryItem.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView

struct CategoryItem: JomloItem, @unchecked Sendable {
    let id: String
    let name: String
    let iconName: String
    let colorHex: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: CategoryItem, rhs: CategoryItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
