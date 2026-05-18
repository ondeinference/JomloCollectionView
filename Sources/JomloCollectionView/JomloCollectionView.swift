//
//  JomloCollectionView.swift
//  JomloCollectionView
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

/// JomloCollectionView is a declarative, section-driven UICollectionView compositional layout engine.
///
/// Inspired by production streaming-app architectures, it provides a protocol-oriented approach
/// to building complex collection view layouts with minimal boilerplate.
///
/// Key concepts:
/// - `JomloSection`: A protocol defining a section's items, layout, and cell configuration
/// - `JomloItem`: A protocol for type-safe, self-configuring cell view models
/// - `JomloCollectionViewController`: A ready-to-use view controller that orchestrates sections
/// - `JomloAnimator`: Declarative cell appearance animations
///
/// Swift 6 strict concurrency is enforced throughout.
