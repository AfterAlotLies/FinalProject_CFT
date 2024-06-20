//
//  CartPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 19.06.2024.
//

import Foundation

protocol ICartPresenter {
    func didLoad(ui: ICartViewController)
    func willLoad(ui: ICartViewController)
}

class CartPresenter: ICartPresenter {
    
    private weak var ui: ICartViewController?
    private let cartDataSource: ICartCollectionViewDataSource
    private let shoppingService: IShoppingCart
    private let networkManager: INetworkManager
    private var cartProductsData = [DataRepository]()
    
    init(cartDataSource: CartCollectionViewDataSource, shoppingService: IShoppingCart, networkManager: INetworkManager) {
        self.cartDataSource = cartDataSource
        self.shoppingService = shoppingService
        self.networkManager = networkManager
    }
    
    func didLoad(ui: ICartViewController) {
        self.ui = ui
        cartDataSource.setDeleteFromCartButton { [weak self] index in
            guard let self = self else { return }
            cartProductsData.forEach {_ in
                self.shoppingService.removeProductData(self.cartProductsData[index].title, 
                                                       self.cartProductsData[index].price,
                                                       self.cartProductsData[index].rating.rate,
                                                       self.cartProductsData[index].image)
            }
            cartProductsData.remove(at: index)
            self.cartDataSource.removeItem(at: index)
            self.ui?.reloadCollection()
        }
    }
    
    func willLoad(ui: ICartViewController) {
        self.ui = ui
        getProductsFromCoreData()
    }
}

private extension CartPresenter {
    
    func getProductsFromCoreData() {
        if let userLogin = KeyStorage.shared.getToken(), !userLogin.isEmpty {
            ui?.getNotificationLabelState(.hidden)
            ui?.getCountProductsLabelState(.nonHidden)
            ui?.getCartCollectionState(.nonHidden)
            cartDataSource.removeAllItems()
            let productData = shoppingService.fetchCartData()
            if let productData {
                ui?.getCountProducts(productData.count)
                cartDataSource.setProductData(productData)
                cartProductsData = productData
                let productImages = productData.map { $0.image }
                productImages.forEach {
                    networkManager.getImageFromUrl($0) { [weak self] imageResponse, error in
                        guard let self = self else { return }
                        if error != nil {
                            DispatchQueue.main.async {
                                self.cartDataSource.setImageData(nil)
                            }
                        } else {
                            if let imageResponse {
                                self.cartDataSource.setImageData(imageResponse)
                            }
                            self.ui?.reloadCollection()
                        }
                    }
                }
            }
        } else {
            ui?.getNotificationLabelState(.nonHidden)
            ui?.getCountProductsLabelState(.hidden)
            ui?.getCartCollectionState(.hidden)
        }
    }
}
