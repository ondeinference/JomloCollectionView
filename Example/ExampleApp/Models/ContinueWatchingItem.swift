//
//  ContinueWatchingItem.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView

struct ContinueWatchingItem: JomloItem, @unchecked Sendable {
    let id: String
    let title: String
    let episodeInfo: String
    let progress: Float
    let colorHex: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: ContinueWatchingItem, rhs: ContinueWatchingItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
