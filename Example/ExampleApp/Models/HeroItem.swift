//
//  HeroItem.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView

struct HeroItem: JomloItem, @unchecked Sendable {
    let id: String
    let title: String
    let subtitle: String
    let gradientColors: (top: String, bottom: String)

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: HeroItem, rhs: HeroItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
