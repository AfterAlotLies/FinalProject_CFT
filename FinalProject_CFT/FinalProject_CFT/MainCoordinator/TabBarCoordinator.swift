//
//  TabBarCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class TabBarCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var tabBarController: UITabBarController
    
    private let tabBarTinColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 177.0 / 255.0, alpha: 1)
    
    init() {
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let productsNavigationController = UINavigationController()
        let cartNavigationController = UINavigationController()
        let accountNavigationController = UINavigationController()
        
        let productsCoordinator = ProductsControllerCoordinator(navigationController: productsNavigationController)
        let cartCoordinator = CartControllerCoordinator(navigationController: cartNavigationController)
        let accountCoordinator = AccountControllerCoordinator(navigationController: accountNavigationController)
        
        childCoordinators += [productsCoordinator, cartCoordinator, accountCoordinator]
        
        productsCoordinator.start()
        cartCoordinator.start()
        accountCoordinator.start()
        
        tabBarController.viewControllers = [
            productsCoordinator.navigationController,
            cartCoordinator.navigationController,
            accountCoordinator.navigationController
        ]
        
        productsNavigationController.tabBarItem = UITabBarItem(title: "Магазин", image: UIImage(named: "storeImage"), selectedImage: nil)
        cartNavigationController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "cartImage"), selectedImage: nil)
        accountNavigationController.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(named: "accountImage"), selectedImage: nil)
        setupTabBarItems()
        addTopBorderToTabBar()
    }
    
}

private extension TabBarCoordinator {
    
    func addTopBorderToTabBar() {
        tabBarController.view.backgroundColor = .systemBackground
        
        tabBarController.tabBar.clipsToBounds = true
        
        tabBarController.tabBar.layer.borderWidth = 0.5
        tabBarController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupTabBarItems() {
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.tintColor = tabBarTinColor
    }
}
