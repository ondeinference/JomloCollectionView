//
//  SceneDelegate.swift
//  JomloCollectionView Example
//
//  Created by Seto Elkahfi on 2026-01-27.
//  Copyright © 2026 Seto Elkahfi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let homeVC = StreamingHomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.navigationBar.prefersLargeTitles = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
