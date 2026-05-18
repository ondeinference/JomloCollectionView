# JomloCollectionView

[![Swift 6.0](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2017%20%7C%20tvOS%2017-blue.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

JomloCollectionView is a small UIKit package for building section based `UICollectionView` screens on iOS and tvOS.

It is meant for screens made from mixed sections: a hero banner, a few horizontal shelves, a grid, maybe a list. Each section owns its items, layout, cell configuration, and selection behavior. The view controller stitches those sections into one compositional layout and keeps the diffable data source out of your app code.

If you have used [JomloTableView](https://github.com/setoelkahfi/JomloTableView), this is the same idea moved to `UICollectionView`, with compositional layouts and Swift 6 concurrency rules.

## Screenshots

<p>
  <img src="assets/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-18%20at%2019.41.17.png" alt="JomloCollectionView example app home screen" width="260">
  <img src="assets/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-18%20at%2019.41.25.png" alt="JomloCollectionView example app shelves and categories" width="260">
  <img src="assets/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-05-18%20at%2019.41.37.png" alt="JomloCollectionView example app see all screen" width="260">
</p>

## What it gives you

- Section objects that define their own layout, items, cells, and selection handling
- `UICollectionViewCompositionalLayout` support without one large layout switch in the view controller
- A diffable data source managed by `JomloCollectionViewController`
- Layout helpers for hero, shelf, grid, list, and banner sections
- Self configuring cells through `JomloSelfConfiguringCell`
- Optional cell appearance animations
- Swift 6 language mode with `Sendable` and `@MainActor` annotations
- UIKit only, with no external package dependencies

## Requirements

- iOS 17.0 or later
- tvOS 17.0 or later
- Swift 6.0 or later
- Xcode 16.0 or later

## Installation

### Swift Package Manager

Add the package to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/setoelkahfi/JomloCollectionView", from: "1.0.0")
]
```

In Xcode, use `File > Add Package Dependencies` and paste the repository URL.

### CocoaPods

Add this to your `Podfile`:

```ruby
pod 'JomloCollectionView', '~> 1.0'
```

Then run:

```bash
pod install
```

## Quick start

Define an item:

```swift
struct MovieItem: JomloItem {
    let id: String
    let title: String
    let posterColor: String

    nonisolated var itemIdentifier: String { id }
}
```

Create a cell that knows how to render that item:

```swift
final class MovieCell: UICollectionViewCell, JomloSelfConfiguringCell {
    private let titleLabel = UILabel()

    func configure(with item: MovieItem) {
        titleLabel.text = item.title
    }
}
```

Put the layout and cell wiring in a section:

```swift
@MainActor
final class MoviesShelfSection: JomloSection {
    let identifier = JomloSectionID("movies")
    var onReloadNeeded: (@MainActor @Sendable () -> Void)?

    private let movies: [MovieItem]

    init(movies: [MovieItem]) {
        self.movies = movies
    }

    func items() -> [any JomloItem] {
        movies
    }

    func layoutSection(
        environment: NSCollectionLayoutEnvironment,
        sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        JomloLayoutFactory.horizontalShelf()
    }

    func cell(
        for item: any JomloItem,
        in collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let movie = item as? MovieItem else {
            return UICollectionViewCell()
        }

        return collectionView.dequeueJomloCell(MovieCell.self, for: indexPath, item: movie)
    }
}
```

Then build the screen from sections:

```swift
final class MoviesViewController: JomloCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerJomloCell(MovieCell.self)
    }
}

let viewController = MoviesViewController(sections: [
    heroSection,
    continueWatchingSection,
    moviesShelfSection,
    categoriesGridSection,
])
```

`JomloCollectionViewController` owns the collection view, builds the compositional layout, applies snapshots, and forwards selection back to the section.

## How the pieces fit

```text
JomloCollectionViewController
  - UICollectionViewCompositionalLayout
  - UICollectionViewDiffableDataSource

Sections
  - provide items
  - build layout sections
  - dequeue and configure cells
  - handle selection

Items
  - provide stable identifiers for diffing
  - carry the data needed by cells
```

## Core types

| Type | What it does |
|------|--------------|
| `JomloSection` | Defines one section's items, layout, cells, supplementary views, selection, and reload callback |
| `JomloItem` | A `Hashable` and `Sendable` view model with a stable `itemIdentifier` |
| `JomloSelfConfiguringCell` | Lets a cell configure itself from one item type |
| `JomloCollectionViewController` | Hosts the collection view, compositional layout, and diffable data source |
| `JomloLayoutFactory` | Creates common compositional layout sections |
| `JomloAnimator` | Runs optional appearance animations as cells are displayed |
| `JomloSectionHeaderView` | A reusable section header with a title and action button |

## Layout presets

| Preset | Use it for |
|--------|------------|
| `.hero()` | A wide featured item with optional paging |
| `.horizontalShelf()` | A horizontally scrolling row of cards |
| `.grid(columns:)` | A multi column grid |
| `.list()` | A single column vertical list |
| `.banner()` | A full width banner section |

## Animations

| Animation | Effect |
|-----------|--------|
| `.fadeIn()` | Fades cells in with a staggered delay |
| `.moveUpWithFade()` | Moves cells up while fading them in |
| `.scaleUp()` | Scales cells from a smaller size while fading them in |

You can set an animation per section with `displayAnimation`, or set a shared `JomloAnimator` on the view controller.

## Example app

The `Example/` directory contains an Xcode project with iOS and tvOS targets. It builds a streaming style home screen with:

- A featured hero section
- Continue watching shelves with progress indicators
- Poster shelves
- A categories grid
- Section headers with a "See All" action

To run it:

```bash
cd Example
open JomloCollectionViewExample.xcodeproj
```

Then choose one of these schemes:

- `JomloCV Example iOS` for an iPhone or iPad simulator
- `JomloCV Example tvOS` for an Apple TV simulator

Most cells, models, sections, and view controllers are shared between the targets. The platform specific app entry points live in their own target folders.

## Moving from JomloTableView

| JomloTableView | JomloCollectionView |
|----------------|---------------------|
| `JomloTableViewSection` | `JomloSection` |
| `JomloTableViewRow` | `JomloItem` |
| `JomloTableViewCell` | `JomloSelfConfiguringCell` |
| `JomloTableView` | `JomloCollectionViewController` |
| `populateView(cell:)` | `configure(with:)` |
| `addSection(section:)` | `setSections([...])` or `appendSection(_:)` |
| Class inheritance | Protocol composition |
| `UITableView` | `UICollectionViewCompositionalLayout` |

## Design notes

The package works best when each section is treated as a small, reusable unit. A section should know how to lay itself out and how to render its items. The screen should only decide which sections appear and in what order.

That keeps the view controller thin, and it makes common product screens easier to change. You can reuse a shelf section with different data, swap a grid from two columns to four, or map server returned section types into local section objects.

## Author

Seto Elkahfi - [@setoelkahfi](https://github.com/setoelkahfi)

## License

JomloCollectionView is available under the MIT license. See [LICENSE](LICENSE) for details.

## Copyright

2026 Onde Inference (Splitfire AB)
