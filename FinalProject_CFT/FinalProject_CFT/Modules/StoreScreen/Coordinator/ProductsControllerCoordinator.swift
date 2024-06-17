//
//  ProductsControllerCoordinator.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

class ProductsControllerCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager()
        let categoriesDataSource = CategoriesCollectionViewDataSource()
        let productsDataSource = ProductsCollectionViewDataSource()
        
        let presenter = ProductsPresenter(networkManager: networkManager,
                                          categoriesDataSource: categoriesDataSource,
                                          productsDataSource: productsDataSource)
        
        let productsController = ProductsListViewController(productsPresenter: presenter,
                                                            categoriesDataSource: categoriesDataSource,
                                                            productsDataSource: productsDataSource)
        productsController.productsControllerCoordinator = self
        navigationController.pushViewController(productsController, animated: true)
    }
}
