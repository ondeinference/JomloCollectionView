//
//  StreamingHomeViewController.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

@MainActor
final class StreamingHomeViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "JomloCV"
        #if os(iOS)
            view.backgroundColor = .systemBackground
        #endif

        // Register cells
        collectionView.registerJomloCell(HeroCell.self)
        collectionView.registerJomloCell(PosterCell.self)
        collectionView.registerJomloCell(CategoryCell.self)
        collectionView.registerJomloCell(ContinueWatchingCell.self)

        // Register header
        collectionView.register(
            JomloSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: JomloSectionHeaderView.reuseIdentifier
        )

        // Load content
        loadContent()
    }

    private func loadContent() {
        let sections: [any JomloSection] = [
            makeHeroSection(),
            makeContinueWatchingSection(),
            makeTrendingSection(),
            makeSeriesSection(),
            makeCategoriesSection(),
            makeMoviesSection(),
        ]

        setSections(sections, animated: true)
    }

    // MARK: - Section Factories

    private func makeHeroSection() -> HeroSection {
        HeroSection(items: [
            HeroItem(
                id: "hero-1",
                title: "The Last Kingdom",
                subtitle: "Season 5 Now Streaming",
                gradientColors: (top: "#1a237e", bottom: "#4a148c")
            ),
            HeroItem(
                id: "hero-2",
                title: "Formula 1: Drive to Survive",
                subtitle: "New Season Available",
                gradientColors: (top: "#b71c1c", bottom: "#e65100")
            ),
            HeroItem(
                id: "hero-3",
                title: "Premier League Live",
                subtitle: "Every Match, Every Week",
                gradientColors: (top: "#1b5e20", bottom: "#004d40")
            ),
        ])
    }

    private func makeContinueWatchingSection() -> ContinueWatchingSection {
        ContinueWatchingSection(items: [
            ContinueWatchingItem(
                id: "cw-1", title: "Breaking Bad", episodeInfo: "S3 E7 \u{00B7} One Minute",
                progress: 0.65, colorHex: "#2e7d32"),
            ContinueWatchingItem(
                id: "cw-2", title: "The Bear", episodeInfo: "S2 E3 \u{00B7} Sundae", progress: 0.3,
                colorHex: "#f57f17"),
            ContinueWatchingItem(
                id: "cw-3", title: "Succession", episodeInfo: "S4 E1 \u{00B7} The Munsters",
                progress: 0.82, colorHex: "#1565c0"),
            ContinueWatchingItem(
                id: "cw-4", title: "Slow Horses", episodeInfo: "S3 E4 \u{00B7} Uninvited",
                progress: 0.45, colorHex: "#6a1b9a"),
        ])
    }

    private func makeTrendingSection() -> ShelfSection {
        ShelfSection(
            id: "trending",
            title: "Trending Now",
            items: [
                PosterItem(id: "t-1", title: "Oppenheimer", year: "2023", colorHex: "#ff6f00"),
                PosterItem(
                    id: "t-2", title: "Killers of the Flower Moon", year: "2023",
                    colorHex: "#4e342e"),
                PosterItem(id: "t-3", title: "Past Lives", year: "2023", colorHex: "#00838f"),
                PosterItem(
                    id: "t-4", title: "Anatomy of a Fall", year: "2023", colorHex: "#283593"),
                PosterItem(id: "t-5", title: "The Holdovers", year: "2023", colorHex: "#2e7d32"),
                PosterItem(id: "t-6", title: "Poor Things", year: "2023", colorHex: "#ad1457"),
            ],
            presenter: self
        )
    }

    private func makeSeriesSection() -> ShelfSection {
        ShelfSection(
            id: "series",
            title: "Popular Series",
            items: [
                PosterItem(id: "s-1", title: "The Bear", year: "2022\u{2013}", colorHex: "#e65100"),
                PosterItem(
                    id: "s-2", title: "Slow Horses", year: "2022\u{2013}", colorHex: "#1a237e"),
                PosterItem(
                    id: "s-3", title: "Severance", year: "2022\u{2013}", colorHex: "#004d40"),
                PosterItem(id: "s-4", title: "Shogun", year: "2024", colorHex: "#b71c1c"),
                PosterItem(id: "s-5", title: "True Detective", year: "2024", colorHex: "#311b92"),
                PosterItem(id: "s-6", title: "Fallout", year: "2024", colorHex: "#33691e"),
            ],
            presenter: self
        )
    }

    private func makeCategoriesSection() -> CategoriesGridSection {
        CategoriesGridSection(items: [
            CategoryItem(id: "cat-1", name: "Movies", iconName: "\u{1F3AC}", colorHex: "#c62828"),
            CategoryItem(id: "cat-2", name: "Series", iconName: "\u{1F4FA}", colorHex: "#ad1457"),
            CategoryItem(id: "cat-3", name: "Sports", iconName: "\u{26BD}", colorHex: "#1565c0"),
            CategoryItem(id: "cat-4", name: "Kids", iconName: "\u{1F9F8}", colorHex: "#2e7d32"),
            CategoryItem(
                id: "cat-5", name: "Documentaries", iconName: "\u{1F30D}", colorHex: "#e65100"),
            CategoryItem(id: "cat-6", name: "Live TV", iconName: "\u{1F4E1}", colorHex: "#4527a0"),
        ])
    }

    private func makeMoviesSection() -> ShelfSection {
        ShelfSection(
            id: "movies",
            title: "New Movies",
            items: [
                PosterItem(id: "m-1", title: "Dune: Part Two", year: "2024", colorHex: "#ff8f00"),
                PosterItem(id: "m-2", title: "Civil War", year: "2024", colorHex: "#455a64"),
                PosterItem(id: "m-3", title: "Challengers", year: "2024", colorHex: "#00695c"),
                PosterItem(
                    id: "m-4", title: "The Zone of Interest", year: "2023", colorHex: "#37474f"),
                PosterItem(
                    id: "m-5", title: "All of Us Strangers", year: "2023", colorHex: "#1a237e"),
            ],
            presenter: self
        )
    }
}

// MARK: - UIColor Hex Extension

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
