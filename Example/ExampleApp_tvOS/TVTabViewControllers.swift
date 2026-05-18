//
//  TVTabViewControllers.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import JomloCollectionView
import UIKit

// MARK: - Series Tab

/// The "Series" tab — shows popular and new series shelves.
@MainActor
final class TVSeriesViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        registerCells()
        loadContent()
    }

    private func registerCells() {
        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.registerJomloCell(TVSeeAllCell.self)
        collectionView.register(
            TVSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVSectionHeaderView.reuseIdentifier
        )
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true
    }

    private func loadContent() {
        setSections(
            [
                TVShelfSection(
                    id: "series-popular", title: "Popular Series",
                    items: [
                        TVContentItem(
                            id: "sp-1", title: "The Bear", subtitle: "2022\u{2013} \u{2022} Comedy",
                            colorHex: "#e65100", isFeatured: true),
                        TVContentItem(
                            id: "sp-2", title: "Slow Horses", subtitle: "2022\u{2013} \u{2022} Spy",
                            colorHex: "#1a237e", isFeatured: false),
                        TVContentItem(
                            id: "sp-3", title: "Severance",
                            subtitle: "2022\u{2013} \u{2022} Sci-Fi", colorHex: "#004d40",
                            isFeatured: false),
                        TVContentItem(
                            id: "sp-4", title: "Shogun", subtitle: "2024 \u{2022} Historical",
                            colorHex: "#b71c1c", isFeatured: true),
                        TVContentItem(
                            id: "sp-5", title: "True Detective", subtitle: "2024 \u{2022} Crime",
                            colorHex: "#311b92", isFeatured: false),
                        TVContentItem(
                            id: "sp-6", title: "Fallout", subtitle: "2024 \u{2022} Sci-Fi",
                            colorHex: "#33691e", isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "series-new", title: "New Episodes This Week",
                    items: [
                        TVContentItem(
                            id: "sn-1", title: "House of\nthe Dragon",
                            subtitle: "S2 \u{2022} Fantasy", colorHex: "#880e4f", isFeatured: true),
                        TVContentItem(
                            id: "sn-2", title: "The Diplomat", subtitle: "S2 \u{2022} Thriller",
                            colorHex: "#1565c0", isFeatured: false),
                        TVContentItem(
                            id: "sn-3", title: "Industry", subtitle: "S3 \u{2022} Drama",
                            colorHex: "#37474f", isFeatured: false),
                        TVContentItem(
                            id: "sn-4", title: "Bad Sisters", subtitle: "S2 \u{2022} Comedy",
                            colorHex: "#2e7d32", isFeatured: false),
                        TVContentItem(
                            id: "sn-5", title: "Reacher", subtitle: "S3 \u{2022} Action",
                            colorHex: "#4e342e", isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "series-scandi", title: "Scandinavian Originals",
                    items: [
                        TVContentItem(
                            id: "sc-1", title: "The Bridge", subtitle: "Crime \u{2022} Thriller",
                            colorHex: "#455a64", isFeatured: false),
                        TVContentItem(
                            id: "sc-2", title: "Borgen", subtitle: "Political \u{2022} Drama",
                            colorHex: "#00695c", isFeatured: false),
                        TVContentItem(
                            id: "sc-3", title: "Beforeigners", subtitle: "Sci-Fi \u{2022} Crime",
                            colorHex: "#283593", isFeatured: true),
                        TVContentItem(
                            id: "sc-4", title: "The Rain", subtitle: "Sci-Fi \u{2022} Drama",
                            colorHex: "#1b5e20", isFeatured: false),
                        TVContentItem(
                            id: "sc-5", title: "Kamikaze", subtitle: "Drama", colorHex: "#6a1b9a",
                            isFeatured: false),
                    ],

                        presenter: self),
            ], animated: false)
    }
}

// MARK: - Movies Tab

/// The "Movies" tab — shows featured films and categories.
@MainActor
final class TVMoviesViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        registerCells()
        loadContent()
    }

    private func registerCells() {
        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.registerJomloCell(TVSeeAllCell.self)
        collectionView.register(
            TVSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVSectionHeaderView.reuseIdentifier
        )
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true
    }

    private func loadContent() {
        setSections(
            [
                TVShelfSection(
                    id: "movies-new", title: "New Releases",
                    items: [
                        TVContentItem(
                            id: "mn-1", title: "Dune:\nPart Two", subtitle: "2024 \u{2022} Sci-Fi",
                            colorHex: "#ff8f00", isFeatured: true),
                        TVContentItem(
                            id: "mn-2", title: "Civil War", subtitle: "2024 \u{2022} Action",
                            colorHex: "#455a64", isFeatured: false),
                        TVContentItem(
                            id: "mn-3", title: "Challengers", subtitle: "2024 \u{2022} Drama",
                            colorHex: "#00695c", isFeatured: false),
                        TVContentItem(
                            id: "mn-4", title: "Furiosa", subtitle: "2024 \u{2022} Action",
                            colorHex: "#795548", isFeatured: false),
                        TVContentItem(
                            id: "mn-5", title: "Inside Out 2", subtitle: "2024 \u{2022} Animation",
                            colorHex: "#7b1fa2", isFeatured: true),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "movies-acclaimed", title: "Critically Acclaimed",
                    items: [
                        TVContentItem(
                            id: "ma-1", title: "Oppenheimer", subtitle: "2023 \u{2022} Drama",
                            colorHex: "#ff6f00", isFeatured: true),
                        TVContentItem(
                            id: "ma-2", title: "Past Lives", subtitle: "2023 \u{2022} Romance",
                            colorHex: "#00838f", isFeatured: false),
                        TVContentItem(
                            id: "ma-3", title: "Anatomy\nof a Fall",
                            subtitle: "2023 \u{2022} Thriller", colorHex: "#283593",
                            isFeatured: false),
                        TVContentItem(
                            id: "ma-4", title: "The Holdovers", subtitle: "2023 \u{2022} Comedy",
                            colorHex: "#2e7d32", isFeatured: false),
                        TVContentItem(
                            id: "ma-5", title: "Poor Things", subtitle: "2023 \u{2022} Fantasy",
                            colorHex: "#ad1457", isFeatured: true),
                        TVContentItem(
                            id: "ma-6", title: "Zone of\nInterest", subtitle: "2023 \u{2022} Drama",
                            colorHex: "#37474f", isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "movies-family", title: "Family Movies",
                    items: [
                        TVContentItem(
                            id: "mf-1", title: "Wish", subtitle: "2023 \u{2022} Animation",
                            colorHex: "#4527a0", isFeatured: false),
                        TVContentItem(
                            id: "mf-2", title: "Migration", subtitle: "2023 \u{2022} Animation",
                            colorHex: "#00838f", isFeatured: false),
                        TVContentItem(
                            id: "mf-3", title: "Wonka", subtitle: "2023 \u{2022} Fantasy",
                            colorHex: "#6a1b9a", isFeatured: true),
                        TVContentItem(
                            id: "mf-4", title: "Elemental", subtitle: "2023 \u{2022} Animation",
                            colorHex: "#e65100", isFeatured: false),
                    ],

                        presenter: self),
            ], animated: false)
    }
}

// MARK: - Sports Tab

/// The "Sport" tab — shows live and upcoming sports content.
@MainActor
final class TVSportsViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        registerCells()
        loadContent()
    }

    private func registerCells() {
        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.registerJomloCell(TVSeeAllCell.self)
        collectionView.register(
            TVSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVSectionHeaderView.reuseIdentifier
        )
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true
    }

    private func loadContent() {
        setSections(
            [
                TVShelfSection(
                    id: "sports-live", title: "Live Now",
                    items: [
                        TVContentItem(
                            id: "sl-1", title: "Premier\nLeague",
                            subtitle: "Live \u{2022} Football", colorHex: "#1a237e",
                            isFeatured: true),
                        TVContentItem(
                            id: "sl-2", title: "Handball\nChampions",
                            subtitle: "Live \u{2022} Handball", colorHex: "#4a148c",
                            isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "sports-upcoming", title: "Upcoming",
                    items: [
                        TVContentItem(
                            id: "su-1", title: "Champions\nLeague",
                            subtitle: "Tomorrow \u{2022} Football", colorHex: "#01579b",
                            isFeatured: false),
                        TVContentItem(
                            id: "su-2", title: "Formula 1", subtitle: "Sunday \u{2022} Racing",
                            colorHex: "#b71c1c", isFeatured: true),
                        TVContentItem(
                            id: "su-3", title: "NHL", subtitle: "Tonight \u{2022} Ice Hockey",
                            colorHex: "#1b5e20", isFeatured: false),
                        TVContentItem(
                            id: "su-4", title: "UFC 310", subtitle: "Saturday \u{2022} MMA",
                            colorHex: "#880e4f", isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "sports-replays", title: "Replays & Highlights",
                    items: [
                        TVContentItem(
                            id: "sr-1", title: "Match of\nthe Day", subtitle: "Football",
                            colorHex: "#2e7d32", isFeatured: false),
                        TVContentItem(
                            id: "sr-2", title: "F1 Highlights", subtitle: "Racing",
                            colorHex: "#c62828", isFeatured: false),
                        TVContentItem(
                            id: "sr-3", title: "Golf\nMajors", subtitle: "Golf",
                            colorHex: "#33691e", isFeatured: false),
                        TVContentItem(
                            id: "sr-4", title: "Biathlon\nWorld Cup", subtitle: "Winter Sport",
                            colorHex: "#0d47a1", isFeatured: false),
                    ],

                        presenter: self),
            ], animated: false)
    }
}

// MARK: - Kids Tab

/// The "Kids" tab — shows children's content.
@MainActor
final class TVKidsViewController: JomloCollectionViewController {

    init() {
        super.init(sections: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.08, alpha: 1.0)
        registerCells()
        loadContent()
    }

    private func registerCells() {
        collectionView.registerJomloCell(TVPosterCell.self)
        collectionView.registerJomloCell(TVSeeAllCell.self)
        collectionView.register(
            TVSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TVSectionHeaderView.reuseIdentifier
        )
        collectionView.clipsToBounds = false
        collectionView.remembersLastFocusedIndexPath = true
    }

    private func loadContent() {
        setSections(
            [
                TVShelfSection(
                    id: "kids-popular", title: "Popular with Kids",
                    items: [
                        TVContentItem(
                            id: "kp-1", title: "Peppa Pig", subtitle: "Animation",
                            colorHex: "#e91e63", isFeatured: true),
                        TVContentItem(
                            id: "kp-2", title: "Paw Patrol", subtitle: "Animation",
                            colorHex: "#1565c0", isFeatured: false),
                        TVContentItem(
                            id: "kp-3", title: "Bluey", subtitle: "Animation", colorHex: "#0097a7",
                            isFeatured: true),
                        TVContentItem(
                            id: "kp-4", title: "CoComelon", subtitle: "Animation",
                            colorHex: "#f57f17", isFeatured: false),
                        TVContentItem(
                            id: "kp-5", title: "Lego Friends", subtitle: "Animation",
                            colorHex: "#7b1fa2", isFeatured: false),
                    ],

                        presenter: self),
                TVShelfSection(
                    id: "kids-movies", title: "Kids Movies",
                    items: [
                        TVContentItem(
                            id: "km-1", title: "Frozen II", subtitle: "2019 \u{2022} Animation",
                            colorHex: "#4fc3f7", isFeatured: true),
                        TVContentItem(
                            id: "km-2", title: "Moana", subtitle: "2016 \u{2022} Animation",
                            colorHex: "#00897b", isFeatured: false),
                        TVContentItem(
                            id: "km-3", title: "Encanto", subtitle: "2021 \u{2022} Animation",
                            colorHex: "#ff8f00", isFeatured: false),
                        TVContentItem(
                            id: "km-4", title: "Luca", subtitle: "2021 \u{2022} Animation",
                            colorHex: "#1565c0", isFeatured: false),
                    ],

                        presenter: self),
            ], animated: false)
    }
}

// MARK: - Search Tab

/// The "Search" tab — placeholder for search functionality.
@MainActor
final class TVSearchViewController: UIViewController {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 42, weight: .medium)
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type to search for movies, series, and sport"
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.4)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)

        let stack = UIStackView(arrangedSubviews: [messageLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
