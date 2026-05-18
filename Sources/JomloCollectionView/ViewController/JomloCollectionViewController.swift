//
//  JomloCollectionViewController.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A view controller that manages a `UICollectionView` with compositional layout,
/// driven by an array of `JomloSection` instances.
///
/// This is the collection-view equivalent of `JomloTableView` — it removes the need
/// to manually conform to data source and delegate protocols. Instead, you provide
/// sections that define their own layout, items, and cell configuration.
///
/// ## Usage
/// ```swift
/// let vc = JomloCollectionViewController(sections: [
///     heroSection,
///     trendingShelf,
///     categoriesGrid
/// ])
/// navigationController?.pushViewController(vc, animated: true)
/// ```
@MainActor
open class JomloCollectionViewController: UIViewController {

    // MARK: - Public Properties

    /// The managed collection view.
    public private(set) lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        #if os(tvOS)
            cv.backgroundColor = .clear
        #else
            cv.backgroundColor = .systemBackground
        #endif
        cv.delegate = self
        return cv
    }()

    /// The sections driving this collection view.
    public private(set) var sections: [any JomloSection]

    /// Optional animator for cell display animations.
    public var animator: JomloAnimator?

    // MARK: - Private Properties

    private var dataSource: UICollectionViewDiffableDataSource<JomloSectionID, AnyJomloItem>!

    // MARK: - Initialization

    /// Creates a new collection view controller with the given sections.
    ///
    /// - Parameter sections: An array of sections to display.
    public init(sections: [any JomloSection] = []) {
        self.sections = sections
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported. Use init(sections:) instead.")
    }

    // MARK: - Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        bindSections()
        applySnapshot()
    }

    // MARK: - Public Methods

    /// Replaces all sections and reloads the collection view.
    ///
    /// - Parameter sections: The new sections to display.
    /// - Parameter animated: Whether to animate the transition.
    public func setSections(_ sections: [any JomloSection], animated: Bool = true) {
        self.sections = sections
        bindSections()
        applySnapshot(animated: animated)
        collectionView.setCollectionViewLayout(makeLayout(), animated: animated)
    }

    /// Appends a section and animates it in.
    ///
    /// - Parameter section: The section to append.
    /// - Parameter animated: Whether to animate the insertion.
    public func appendSection(_ section: any JomloSection, animated: Bool = true) {
        sections.append(section)
        bindSection(section)
        applySnapshot(animated: animated)
        collectionView.setCollectionViewLayout(makeLayout(), animated: animated)
    }

    /// Reloads a specific section by its identifier.
    ///
    /// - Parameter identifier: The identifier of the section to reload.
    /// - Parameter animated: Whether to animate the reload.
    public func reloadSection(identifier: JomloSectionID, animated: Bool = true) {
        applySnapshot(animated: animated)
    }

    /// Triggers a full snapshot reapply.
    ///
    /// - Parameter animated: Whether to animate changes.
    public func reloadData(animated: Bool = true) {
        applySnapshot(animated: animated)
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self, sectionIndex < self.sections.count else {
                return Self.makeEmptyLayoutSection()
            }
            return self.sections[sectionIndex].layoutSection(
                environment: environment,
                sectionIndex: sectionIndex
            )
        }
    }

    private static func makeEmptyLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<JomloSectionID, AnyJomloItem>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemWrapper in
            guard let self else { return UICollectionViewCell() }
            guard indexPath.section < self.sections.count else { return UICollectionViewCell() }

            let section = self.sections[indexPath.section]
            return section.cell(for: itemWrapper.base, in: collectionView, at: indexPath)
        }

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return nil }
            guard indexPath.section < self.sections.count else { return nil }

            let section = self.sections[indexPath.section]
            return section.supplementaryView(ofKind: kind, in: collectionView, at: indexPath)
        }
    }

    private func bindSections() {
        for section in sections {
            bindSection(section)
        }
    }

    private func bindSection(_ section: any JomloSection) {
        section.onReloadNeeded = { [weak self] in
            self?.applySnapshot(animated: true)
        }
    }

    private func applySnapshot(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<JomloSectionID, AnyJomloItem>()

        for section in sections {
            let sectionId = section.identifier
            snapshot.appendSections([sectionId])
            let items = section.items().map { AnyJomloItem($0) }
            snapshot.appendItems(items, toSection: sectionId)
        }

        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: - UICollectionViewDelegate

extension JomloCollectionViewController: UICollectionViewDelegate {

    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.section < sections.count else { return }
        let section = sections[indexPath.section]
        let items = section.items()
        guard indexPath.item < items.count else { return }
        section.didSelectItem(items[indexPath.item], at: indexPath)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard indexPath.section < sections.count else { return }
        let section = sections[indexPath.section]

        // Section-specific animation
        if let animation = section.displayAnimation {
            animation(cell, indexPath, collectionView)
        }
        // Global animator
        else if let animator {
            animator.animate(view: cell, at: indexPath, in: collectionView)
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        // Can be overridden by subclasses
    }
}
