//
//  JomloAnimator.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// Provides declarative cell appearance animations for collection view cells.
///
/// Animations are applied as cells appear on screen. Once all visible cells
/// have been animated, the animator stops to avoid re-animating on scroll.
@MainActor
public final class JomloAnimator: Sendable {

    /// A closure that animates a cell as it appears.
    ///
    /// - Parameters:
    ///   - view: The cell view to animate.
    ///   - indexPath: The index path of the cell.
    ///   - collectionView: The parent collection view.
    public typealias Animation = @MainActor @Sendable (UIView, IndexPath, UICollectionView) -> Void

    private let animation: Animation
    private var hasAnimatedAllCells = false

    /// Creates an animator with a custom animation closure.
    ///
    /// - Parameter animation: The animation to apply to each cell.
    public init(animation: @escaping Animation) {
        self.animation = animation
    }

    /// Animates a cell at the given index path.
    ///
    /// Stops animating after all initially visible cells have been shown.
    public func animate(view: UIView, at indexPath: IndexPath, in collectionView: UICollectionView)
    {
        guard !hasAnimatedAllCells else { return }

        animation(view, indexPath, collectionView)

        hasAnimatedAllCells =
            collectionView.visibleCells.last == collectionView.cellForItem(at: indexPath)
    }

    /// Resets the animator so it will animate cells again.
    public func reset() {
        hasAnimatedAllCells = false
    }
}

// MARK: - Built-in Animations

extension JomloAnimator {

    /// A fade-in animation with staggered delay per row.
    ///
    /// - Parameters:
    ///   - duration: The duration of each cell's fade animation.
    ///   - delayFactor: Multiplied by the row index to stagger animations.
    /// - Returns: An animation closure.
    public static func fadeIn(duration: TimeInterval = 0.4, delayFactor: Double = 0.05) -> Animation
    {
        { view, indexPath, _ in
            view.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.item),
                animations: {
                    view.alpha = 1
                }
            )
        }
    }

    /// A move-up-with-fade animation.
    ///
    /// - Parameters:
    ///   - offset: How far down the cell starts before moving up.
    ///   - duration: The animation duration.
    ///   - delayFactor: Multiplied by the row index to stagger animations.
    /// - Returns: An animation closure.
    public static func moveUpWithFade(
        offset: CGFloat = 30,
        duration: TimeInterval = 0.5,
        delayFactor: Double = 0.05
    ) -> Animation {
        { view, indexPath, _ in
            view.transform = CGAffineTransform(translationX: 0, y: offset)
            view.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.item),
                options: [.curveEaseInOut],
                animations: {
                    view.transform = .identity
                    view.alpha = 1
                }
            )
        }
    }

    /// A scale-up animation from a smaller size.
    ///
    /// - Parameters:
    ///   - initialScale: The starting scale (e.g., 0.8).
    ///   - duration: The animation duration.
    ///   - delayFactor: Multiplied by the row index to stagger animations.
    /// - Returns: An animation closure.
    public static func scaleUp(
        initialScale: CGFloat = 0.85,
        duration: TimeInterval = 0.4,
        delayFactor: Double = 0.05
    ) -> Animation {
        { view, indexPath, _ in
            view.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
            view.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.item),
                options: [.curveEaseOut],
                animations: {
                    view.transform = .identity
                    view.alpha = 1
                }
            )
        }
    }
}
