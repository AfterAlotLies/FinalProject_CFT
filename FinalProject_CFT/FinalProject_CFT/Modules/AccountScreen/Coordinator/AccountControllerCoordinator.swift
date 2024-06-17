//
//  AccountControllerCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

class AccountControllerCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let accountViewController = AccountViewController()
        accountViewController.accountControllerCoordinator = self
        navigationController.pushViewController(accountViewController, animated: true)
    }
}
