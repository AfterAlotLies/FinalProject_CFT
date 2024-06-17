//
//  CartControllerCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

class CartControllerCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartViewController = CartViewController()
        cartViewController.carControllerCoordinator = self
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
}
