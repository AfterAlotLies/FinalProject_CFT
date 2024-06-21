//
//  ProductsInfoPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import Foundation

// MARK: - IProductsInfoPresenter protocol
protocol IProductsInfoPresenter {
    func didLoad(ui: IProductInformationViewContoller)
}

// MARK: - ProductsInfoPresenter
class ProductsInfoPresenter: IProductsInfoPresenter {
    
    private enum Constants {
        static let successMessage = "Your product added to your cart!"
        static let errorMessage = "You are not logged in. Please retry after log in"
    }
    
    private weak var ui: IProductInformationViewContoller?
    private let productData: DataRepository
    private let networkManager: INetworkManager
    private let shoppingService: IShoppingCart
    
    // MARK: - Init()
    init(productData: DataRepository, networkManager: INetworkManager, shoppingService: IShoppingCart) {
        self.productData = productData
        self.networkManager = networkManager
        self.shoppingService = shoppingService
    }
    
    func didLoad(ui: IProductInformationViewContoller) {
        self.ui = ui
        setUI()
        setAddToCartAction()
    }
}

// MARK: - ProductsInfoPresenter private methods
private extension ProductsInfoPresenter {
    
    func setUI() {
        getImageForProduct()
    }
    
    func setAddToCartAction() {
        ui?.getActionHandler(completion: { [weak self] in
            guard let self = self else { return }
            if let userLogin = KeyStorage.shared.getToken(), !userLogin.isEmpty {
                self.shoppingService.addCartData(productData: productData)
                self.ui?.showSuccessAlert(successMessage: Constants.successMessage)
            } else {
                self.ui?.showErrorAlert(errorMessage: Constants.errorMessage)
            }
        })
    }
    
    func getImageForProduct() {
        networkManager.getImageFromUrl(productData.image) { [weak self] imageResponse, error in
            guard let self = self else { return }
            if error != nil {
                self.ui?.setData(data: ProductInfoModel(title: productData.title,
                                                        price: productData.price,
                                                        description: productData.description,
                                                        rating: productData.rating.rate,
                                                        image: nil))
            } else {
                if let imageResponse {
                    self.ui?.setData(data: ProductInfoModel(title: productData.title,
                                                            price: productData.price,
                                                            description: productData.description,
                                                            rating: productData.rating.rate,
                                                            image: imageResponse))
                }
            }
        }
    }
}
