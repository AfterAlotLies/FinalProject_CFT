//
//  ProductsInfoPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import Foundation

protocol IProductsInfoPresenter {
    func didLoad(ui: IProductInformationViewContoller)
}

class ProductsInfoPresenter: IProductsInfoPresenter {
    
    private weak var ui: IProductInformationViewContoller?
    private let productData: DataRepository
    private let networkManager: INetworkManager
    
    init(productData: DataRepository, networkManager: INetworkManager) {
        self.productData = productData
        self.networkManager = networkManager
    }
    
    func didLoad(ui: IProductInformationViewContoller) {
        self.ui = ui
        setUI()
    }
}

private extension ProductsInfoPresenter {
    
    func setUI() {
        getImageForProduct()
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
