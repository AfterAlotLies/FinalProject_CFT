//
//  ProductsPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import Foundation

// MARK: - IProductsPresenter protocol
protocol IProductsPresenter {
    func didLoad(ui: IProductsListViewController)
    func didSelectItem(_ indexItem: IndexPath.Element)
    func setupNextController(passingDataIndex: IndexPath.Element)
}

// MARK: - ProductsPresenter
class ProductsPresenter: IProductsPresenter {
    
    private enum Constants {
        static let successMessage = "Your product added to your cart!"
        static let errorMessage = "You are not logged in. Please retry after log in"
    }
    
    private weak var ui: IProductsListViewController?
    
    private let networkManager: INetworkManager
    private let categoriesDataSource: ICategoriesCollectionViewDataSource
    private let productsDataSource: IProductsCollectionViewDataSource
    private let shoppingCartService: IShoppingCart
    
    private var dataRepository = [DataRepository]()
    
    // MARK: - Init()
    init(networkManager: INetworkManager, categoriesDataSource: CategoriesCollectionViewDataSource, productsDataSource: ProductsCollectionViewDataSource, shoppingCartService: IShoppingCart) {
        self.networkManager = networkManager
        self.categoriesDataSource = categoriesDataSource
        self.productsDataSource = productsDataSource
        self.shoppingCartService = shoppingCartService
    }
    
    func didLoad(ui: IProductsListViewController) {
        self.ui = ui
        getProductsData()
        setAddToCartButtonAction()
    }
    
    func didSelectItem(_ indexItem: IndexPath.Element) {
        categoriesDataSource.changeSelectedCell(indexPath: indexItem)
        switch indexItem {
        case 0:
            getProducts(for: .electronics)
        case 1:
            getProducts(for: .jewelery)
        case 2:
            getProducts(for: .mens)
        case 3:
            getProducts(for: .womens)
        default:
            break
        }
        ui?.reloadCategoriesCollectionView()
    }
    
    func setupNextController(passingDataIndex: IndexPath.Element) {
        let productInfoPresenter = ProductsInfoPresenter(productData: dataRepository[passingDataIndex], 
                                                         networkManager: networkManager,
                                                         shoppingService: shoppingCartService)
        let productInfoController = ProductInformationViewContoller(productsInfoPresenter: productInfoPresenter)
        ui?.showNextController(productInfoController)
    }
}

// MARK: - ProductsPresenter private methods
private extension ProductsPresenter {
    
    func getProductsData() {
        getProducts(for: .electronics)
    }
    
    func setAddToCartButtonAction() {
        productsDataSource.setAddToCartButton { [weak self] index in
            guard let self = self else { return }
            if let userToken = KeyStorage.shared.getToken(), !userToken.isEmpty {
                self.shoppingCartService.addCartData(productData: dataRepository[index])
                self.ui?.showSuccess(successMessage: Constants.successMessage)
            } else {
                self.ui?.showError(errorMessage: Constants.errorMessage)
            }
        }
    }
    
    func getProducts(for category: RequestType) {
        productsDataSource.removeItems()
        dataRepository.removeAll()
        ui?.setLoaderState(state: .animating)
        ui?.setStateCategoriesCollection(.disabled)
        networkManager.getProducts(for: category) { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                DispatchQueue.main.async {
                    self.ui?.showError(errorMessage: error?.localizedDescription ?? "something gone wrong")
                }
            } else {
                if let response {
                    self.productsDataSource.addProducts(data: response)
                    self.ui?.setProductsCount(response.count)
                    response.forEach {
                        self.networkManager.getImageFromUrl($0.image) { imageResponse, error in
                            if error != nil {
                                DispatchQueue.main.async {
                                    self.productsDataSource.addImage(image: nil)
                                }
                            } else {
                                if let imageResponse {
                                    self.productsDataSource.addImage(image: imageResponse)
                                }
                            }
                            self.ui?.reloadProductsCollectionView()
                            self.ui?.setLoaderState(state: .nonAnimating)
                            self.ui?.setStateCategoriesCollection(.enabled)
                        }
                    }
                    self.dataRepository = response
                }
            }
        }
    }
}
