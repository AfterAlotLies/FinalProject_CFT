//
//  SceneDelegate.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var tabBarCoordinator: TabBarCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
      
        self.tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator?.start()

        window.rootViewController = tabBarCoordinator?.tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}

