//
//  TVContentItem.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView

/// A content item representing a movie or show on the big screen.
struct TVContentItem: JomloItem, @unchecked Sendable {
    let id: String
    let title: String
    let subtitle: String
    let colorHex: String
    let isFeatured: Bool

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: TVContentItem, rhs: TVContentItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A hero/featured item with richer metadata for the top-shelf style display.
struct TVHeroItem: JomloItem, @unchecked Sendable {
    let id: String
    let title: String
    let tagline: String
    let metadata: String
    let gradientTop: String
    let gradientBottom: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: TVHeroItem, rhs: TVHeroItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A category/channel item for the grid navigation.
struct TVCategoryItem: JomloItem, @unchecked Sendable {
    let id: String
    let name: String
    let icon: String
    let colorHex: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: TVCategoryItem, rhs: TVCategoryItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A sentinel item that renders as the "See All" card at the end of a shelf.
/// Tapping it (or pressing select on the Siri Remote) pushes the full grid page.
struct TVSeeAllItem: JomloItem, @unchecked Sendable {
    let id: String
    let sectionTitle: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: TVSeeAllItem, rhs: TVSeeAllItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// A "continue watching" item with progress state.
struct TVResumeItem: JomloItem, @unchecked Sendable {
    let id: String
    let title: String
    let episodeInfo: String
    let progress: Float
    let colorHex: String
    let remainingTime: String

    nonisolated var itemIdentifier: String { id }

    nonisolated static func == (lhs: TVResumeItem, rhs: TVResumeItem) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
