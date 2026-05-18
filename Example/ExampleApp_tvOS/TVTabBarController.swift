//
//  TVTabBarController.swift
//  JomloCV tvOS Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

/// A tab bar controller mimicking the Viaplay tvOS app navigation structure.
///
/// The tvOS tab bar sits at the top of the screen and is revealed by swiping up
/// on the Siri Remote. Each tab represents a content category page, and focus
/// transitions from the tab bar to the selected view controller's content.
///
/// This implementation includes the focus-handoff pattern from Viaplay's
/// `TabBarController` — when focus moves from the tab bar down to content,
/// we redirect focus to the selected view controller for smooth navigation.
@MainActor
final class TVTabBarController: UITabBarController {

    private var shouldGiveFocusToSelectedViewController = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        setupTabs()
    }

    // MARK: - Focus Engine

    /// Redirects focus to the selected view controller when transitioning
    /// from the tab bar down to content — ensures the BlocksViewController
    /// (or equivalent) gains proper focus control.
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        guard let selectedViewController, shouldGiveFocusToSelectedViewController else {
            return super.preferredFocusEnvironments
        }
        shouldGiveFocusToSelectedViewController = false
        return [selectedViewController]
    }

    /// Intercepts focus transitions from the tab bar to content.
    /// When focus moves away from the tab bar downward, we set a flag
    /// and force a focus update so `preferredFocusEnvironments` can
    /// hand focus to the selected view controller cleanly.
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        if let nextFocusedView = context.nextFocusedView,
            !nextFocusedView.isDescendant(of: tabBar),
            let previouslyFocusedView = context.previouslyFocusedView,
            previouslyFocusedView.isDescendant(of: tabBar)
        {
            shouldGiveFocusToSelectedViewController = true
            setNeedsFocusUpdate()
            updateFocusIfNeeded()
            return false
        }

        shouldGiveFocusToSelectedViewController = false
        return true
    }

    // MARK: - Tab Configuration

    private func setupTabs() {
        let homeVC = TVStreamingHomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        homeVC.tabBarItem.accessibilityIdentifier = "Start"
        let homeNav = UINavigationController(rootViewController: homeVC)

        let seriesVC = TVSeriesViewController()
        seriesVC.tabBarItem = UITabBarItem(title: "Series", image: nil, tag: 1)
        seriesVC.tabBarItem.accessibilityIdentifier = "Series"
        let seriesNav = UINavigationController(rootViewController: seriesVC)

        let moviesVC = TVMoviesViewController()
        moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: nil, tag: 2)
        moviesVC.tabBarItem.accessibilityIdentifier = "Movies"
        let moviesNav = UINavigationController(rootViewController: moviesVC)

        let sportsVC = TVSportsViewController()
        sportsVC.tabBarItem = UITabBarItem(title: "Sport", image: nil, tag: 3)
        sportsVC.tabBarItem.accessibilityIdentifier = "Sports"
        let sportsNav = UINavigationController(rootViewController: sportsVC)

        let kidsVC = TVKidsViewController()
        kidsVC.tabBarItem = UITabBarItem(title: "Kids", image: nil, tag: 4)
        kidsVC.tabBarItem.accessibilityIdentifier = "Kids"
        let kidsNav = UINavigationController(rootViewController: kidsVC)

        let searchVC = TVSearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 5)
        searchVC.tabBarItem.accessibilityIdentifier = "Search"
        let searchNav = UINavigationController(rootViewController: searchVC)

        // Copy tabBarItem from the root VC to the nav so the tab bar shows titles
        homeNav.tabBarItem = homeVC.tabBarItem
        seriesNav.tabBarItem = seriesVC.tabBarItem
        moviesNav.tabBarItem = moviesVC.tabBarItem
        sportsNav.tabBarItem = sportsVC.tabBarItem
        kidsNav.tabBarItem = kidsVC.tabBarItem
        searchNav.tabBarItem = searchVC.tabBarItem

        viewControllers = [homeNav, seriesNav, moviesNav, sportsNav, kidsNav, searchNav]
    }
}
