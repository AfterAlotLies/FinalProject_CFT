//
//  ProductsPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import Foundation

enum RequestType: String {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case mens = "men's%20clothing"
    case womens = "women's%20clothing"
}

protocol IProductsPresenter {
    func didLoad(ui: IProductsListViewController)
    func didSelectItem(_ indexItem: IndexPath.Element)
    func setupNextController(passingDataIndex: IndexPath.Element)
}

class ProductsPresenter: IProductsPresenter {
    
    private weak var ui: IProductsListViewController?
    
    private let networkManager: INetworkManager
    private let categoriesDataSource: CategoriesCollectionViewDataSource
    private let productsDataSource: ProductsCollectionViewDataSource
    
    private var dataRepository = [DataRepository]()
    
    init(networkManager: INetworkManager, categoriesDataSource: CategoriesCollectionViewDataSource, productsDataSource: ProductsCollectionViewDataSource) {
        self.networkManager = networkManager
        self.categoriesDataSource = categoriesDataSource
        self.productsDataSource = productsDataSource
    }
    
    func didLoad(ui: IProductsListViewController) {
        self.ui = ui
        getProductsData()
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
        let productInfoPresenter = ProductsInfoPresenter(productData: dataRepository[passingDataIndex], networkManager: networkManager)
        let productInfoController = ProductInformationViewContoller(productsInfoPresenter: productInfoPresenter)
        ui?.showNextController(productInfoController)
    }
}

private extension ProductsPresenter {
    
    func getProductsData() {
        getProducts(for: .electronics)
    }
    
    func getProducts(for category: RequestType) {
        productsDataSource.removeItems()
        dataRepository.removeAll()
        ui?.setLoaderState(state: .animating)
        networkManager.getProducts(for: category) { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                self.ui?.showError(errorMessage: error?.localizedDescription ?? "something gone wrong")
            } else {
                if let response {
                    self.productsDataSource.addProducts(data: response)
                    self.ui?.setProductsCount(response.count)
                    response.forEach {
                        self.networkManager.getImageFromUrl($0.image) { imageResponse, error in
                            if error != nil {
                                self.ui?.showError(errorMessage: error?.localizedDescription ?? "something gone wrong")
                            } else {
                                if let imageResponse {
                                    self.productsDataSource.addImage(image: imageResponse)
                                }
                            }
                            self.ui?.reloadProductsCollectionView()
                            self.ui?.setLoaderState(state: .nonAnimating)
                        }
                    }
                    self.dataRepository = response
                }
            }
        }
    }
}
