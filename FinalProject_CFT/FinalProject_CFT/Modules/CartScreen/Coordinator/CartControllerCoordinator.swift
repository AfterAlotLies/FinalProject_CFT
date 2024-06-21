//
//  CartControllerCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - CartControllerCoordinator
class CartControllerCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager()
        let cartDataSource = CartCollectionViewDataSource()
        let shoppingService = ShoppingCartService()
        let cartPresenter = CartPresenter(cartDataSource: cartDataSource,
                                          shoppingService: shoppingService,
                                          networkManager: networkManager)
        let cartViewController = CartViewController(cartDataSource: cartDataSource,
                                                    cartPresenter: cartPresenter)
        cartViewController.carControllerCoordinator = self
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
}
