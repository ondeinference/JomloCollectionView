//
//  TVStreamingHomeViewController.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

/// The main view controller for the tvOS example app.
///
/// Demonstrates a streaming-service home screen optimized for Apple TV:
/// - Full-width hero section with group-paging for Siri Remote swipes
/// - "Continue Watching" shelf with progress indicators
/// - Multiple content shelves with large poster cards
/// - Category navigation row
/// - All cells use the tvOS focus engine with scale + shadow animations
@MainActor
final class TVStreamingHomeViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)

        // Register TV-optimized cells
        collectionView.registerJomloCell(TVHeroCell.self)
        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.registerJomloCell(TVSeeAllCell.self)
        collectionView.registerJomloCell(TVCategoryCell.self)
        collectionView.registerJomloCell(TVResumeCell.self)

        // Register TV section header
        collectionView.register(
            TVSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVSectionHeaderView.reuseIdentifier
        )

        // Ensure cells can receive focus outside visible bounds during scrolling
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true

        loadContent()
    }

    // MARK: - Content Assembly

    private func loadContent() {
        let sections: [any JomloSection] = [
            makeHeroSection(),
            makeResumeSection(),
            makeTrendingShelf(),
            makeCategorySection(),
            makeSeriesShelf(),
            makeMoviesShelf(),
            makeSportsShelf(),
        ]
        setSections(sections, animated: false)
    }

    // MARK: - Section Factories

    private func makeHeroSection() -> TVHeroSection {
        TVHeroSection(items: [
            TVHeroItem(
                id: "hero-1",
                title: "The Last Kingdom",
                tagline: "The epic saga concludes",
                metadata: "Season 5 \u{2022} Drama \u{2022} 2022",
                gradientTop: "#1a237e",
                gradientBottom: "#0d47a1"
            ),
            TVHeroItem(
                id: "hero-2",
                title: "Formula 1:\nDrive to Survive",
                tagline: "Every race. Every rivalry.",
                metadata: "Season 6 \u{2022} Documentary \u{2022} 2024",
                gradientTop: "#b71c1c",
                gradientBottom: "#880e4f"
            ),
            TVHeroItem(
                id: "hero-3",
                title: "Premier League",
                tagline: "Every match. Every week. Live.",
                metadata: "Live Sport \u{2022} Football \u{2022} 2024-25",
                gradientTop: "#1b5e20",
                gradientBottom: "#004d40"
            ),
            TVHeroItem(
                id: "hero-4",
                title: "Dune: Part Two",
                tagline: "The legend continues",
                metadata: "2024 \u{2022} Sci-Fi \u{2022} 2h 46m",
                gradientTop: "#e65100",
                gradientBottom: "#bf360c"
            ),
        ])
    }

    private func makeResumeSection() -> TVResumeSection {
        TVResumeSection(items: [
            TVResumeItem(
                id: "r-1", title: "Breaking Bad", episodeInfo: "S3 E7 \u{2022} One Minute",
                progress: 0.65, colorHex: "#2e7d32", remainingTime: "18 min left"),
            TVResumeItem(
                id: "r-2", title: "The Bear", episodeInfo: "S2 E3 \u{2022} Sundae", progress: 0.3,
                colorHex: "#f57f17", remainingTime: "24 min left"),
            TVResumeItem(
                id: "r-3", title: "Succession", episodeInfo: "S4 E1 \u{2022} The Munsters",
                progress: 0.82, colorHex: "#1565c0", remainingTime: "11 min left"),
            TVResumeItem(
                id: "r-4", title: "Slow Horses", episodeInfo: "S3 E4 \u{2022} Uninvited",
                progress: 0.45, colorHex: "#6a1b9a", remainingTime: "28 min left"),
            TVResumeItem(
                id: "r-5", title: "True Detective", episodeInfo: "S4 E2 \u{2022} Night Country",
                progress: 0.15, colorHex: "#37474f", remainingTime: "52 min left"),
        ])
    }

    private func makeTrendingShelf() -> TVShelfSection {
        TVShelfSection(
            id: "trending",
            title: "Trending Now",
            items: [
                TVContentItem(
                    id: "t-1", title: "Oppenheimer", subtitle: "2023 \u{2022} Drama",
                    colorHex: "#ff6f00", isFeatured: true),
                TVContentItem(
                    id: "t-2", title: "Killers of the\nFlower Moon",
                    subtitle: "2023 \u{2022} Crime", colorHex: "#4e342e", isFeatured: false),
                TVContentItem(
                    id: "t-3", title: "Past Lives", subtitle: "2023 \u{2022} Romance",
                    colorHex: "#00838f", isFeatured: false),
                TVContentItem(
                    id: "t-4", title: "Anatomy\nof a Fall", subtitle: "2023 \u{2022} Thriller",
                    colorHex: "#283593", isFeatured: false),
                TVContentItem(
                    id: "t-5", title: "The Holdovers", subtitle: "2023 \u{2022} Comedy",
                    colorHex: "#2e7d32", isFeatured: false),
                TVContentItem(
                    id: "t-6", title: "Poor Things", subtitle: "2023 \u{2022} Fantasy",
                    colorHex: "#ad1457", isFeatured: true),
                TVContentItem(
                    id: "t-7", title: "The Zone\nof Interest", subtitle: "2023 \u{2022} Drama",
                    colorHex: "#37474f", isFeatured: false),
            ],
            presenter: self
        )
    }

    private func makeCategorySection() -> TVCategorySection {
        TVCategorySection(items: [
            TVCategoryItem(id: "cat-1", name: "Movies", icon: "\u{1F3AC}", colorHex: "#c62828"),
            TVCategoryItem(id: "cat-2", name: "Series", icon: "\u{1F4FA}", colorHex: "#6a1b9a"),
            TVCategoryItem(id: "cat-3", name: "Sport", icon: "\u{26BD}", colorHex: "#1565c0"),
            TVCategoryItem(id: "cat-4", name: "Kids", icon: "\u{1F9F8}", colorHex: "#2e7d32"),
            TVCategoryItem(
                id: "cat-5", name: "Documentaries", icon: "\u{1F30D}", colorHex: "#e65100"),
            TVCategoryItem(id: "cat-6", name: "Live TV", icon: "\u{1F4E1}", colorHex: "#283593"),
        ])
    }

    private func makeSeriesShelf() -> TVShelfSection {
        TVShelfSection(
            id: "series",
            title: "Popular Series",
            items: [
                TVContentItem(
                    id: "s-1", title: "The Bear", subtitle: "2022\u{2013} \u{2022} Comedy",
                    colorHex: "#e65100", isFeatured: true),
                TVContentItem(
                    id: "s-2", title: "Slow Horses", subtitle: "2022\u{2013} \u{2022} Spy",
                    colorHex: "#1a237e", isFeatured: false),
                TVContentItem(
                    id: "s-3", title: "Severance", subtitle: "2022\u{2013} \u{2022} Sci-Fi",
                    colorHex: "#004d40", isFeatured: false),
                TVContentItem(
                    id: "s-4", title: "Shogun", subtitle: "2024 \u{2022} Historical",
                    colorHex: "#b71c1c", isFeatured: true),
                TVContentItem(
                    id: "s-5", title: "True Detective", subtitle: "2024 \u{2022} Crime",
                    colorHex: "#311b92", isFeatured: false),
                TVContentItem(
                    id: "s-6", title: "Fallout", subtitle: "2024 \u{2022} Sci-Fi",
                    colorHex: "#33691e", isFeatured: false),
            ],
            presenter: self
        )
    }

    private func makeMoviesShelf() -> TVShelfSection {
        TVShelfSection(
            id: "movies",
            title: "New Releases",
            items: [
                TVContentItem(
                    id: "m-1", title: "Dune:\nPart Two", subtitle: "2024 \u{2022} Sci-Fi",
                    colorHex: "#ff8f00", isFeatured: true),
                TVContentItem(
                    id: "m-2", title: "Civil War", subtitle: "2024 \u{2022} Action",
                    colorHex: "#455a64", isFeatured: false),
                TVContentItem(
                    id: "m-3", title: "Challengers", subtitle: "2024 \u{2022} Drama",
                    colorHex: "#00695c", isFeatured: false),
                TVContentItem(
                    id: "m-4", title: "Furiosa", subtitle: "2024 \u{2022} Action",
                    colorHex: "#795548", isFeatured: false),
                TVContentItem(
                    id: "m-5", title: "Inside Out 2", subtitle: "2024 \u{2022} Animation",
                    colorHex: "#7b1fa2", isFeatured: true),
            ],
            presenter: self
        )
    }

    private func makeSportsShelf() -> TVShelfSection {
        TVShelfSection(
            id: "sports",
            title: "Live & Upcoming Sport",
            items: [
                TVContentItem(
                    id: "sp-1", title: "Premier\nLeague", subtitle: "Live \u{2022} Football",
                    colorHex: "#1a237e", isFeatured: true),
                TVContentItem(
                    id: "sp-2", title: "Champions\nLeague", subtitle: "Tomorrow \u{2022} Football",
                    colorHex: "#01579b", isFeatured: false),
                TVContentItem(
                    id: "sp-3", title: "Formula 1", subtitle: "Sunday \u{2022} Racing",
                    colorHex: "#b71c1c", isFeatured: true),
                TVContentItem(
                    id: "sp-4", title: "Handball", subtitle: "Today \u{2022} Live",
                    colorHex: "#4a148c", isFeatured: false),
                TVContentItem(
                    id: "sp-5", title: "NHL", subtitle: "Tonight \u{2022} Ice Hockey",
                    colorHex: "#1b5e20", isFeatured: false),
            ],
            presenter: self
        )
    }
}
