//
//  TabBarCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

// MARK: - TabBarCoordinator
class TabBarCoordinator: Coordinator {
    
    private enum Constants {
        static let tabBarTinColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 177.0 / 255.0, alpha: 1)
        
        static let productsTabBarTitle = "Shop"
        static let cartTabBarTitle = "Cart"
        static let accountTabBarTitle = "Account"
        
        static let productTabBarImage = UIImage(named: "storeImage")
        static let cartTabBarImage = UIImage(named: "cartImage")
        static let accountTabBarImage = UIImage(named: "accountImage")
    }
    
    var childCoordinators = [Coordinator]()
    var tabBarController: UITabBarController
    
    init() {
        self.tabBarController = UITabBarController()
    }

    
    func start() {
        setupViewControllers()
        addTopBorderToTabBar()
    }
    
}

// MARK: - TabBarCoordinator private methods
private extension TabBarCoordinator {
    
    func setupViewControllers() {
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
        
        productsNavigationController.tabBarItem = UITabBarItem(title: Constants.productsTabBarTitle, image: Constants.productTabBarImage, selectedImage: nil)
        cartNavigationController.tabBarItem = UITabBarItem(title: Constants.cartTabBarTitle, image: Constants.cartTabBarImage, selectedImage: nil)
        accountNavigationController.tabBarItem = UITabBarItem(title: Constants.accountTabBarTitle, image: Constants.accountTabBarImage, selectedImage: nil)
    }
    
    func addTopBorderToTabBar() {
        tabBarController.view.backgroundColor = .systemBackground
        
        tabBarController.tabBar.clipsToBounds = true
        
        tabBarController.tabBar.layer.borderWidth = 0.5
        tabBarController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
}
