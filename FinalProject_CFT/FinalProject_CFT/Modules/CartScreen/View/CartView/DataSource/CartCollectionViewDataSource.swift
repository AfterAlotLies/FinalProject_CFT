//
//  CartCollectionViewDataSource.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 20.06.2024.
//

import UIKit

protocol ICartCollectionViewDataSource {
    func setProductData(_ data: [DataRepository])
    func setImageData(_ data: UIImage?)
    func setDeleteFromCartButton(completion: ((Int) -> Void)?)
    func removeItem(at index: Int)
    func removeAllItems()
}

class CartCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var deleteFromCartButton: ((Int) -> Void)?
    private var productData = [DataRepository]()
    private var productsImages = [UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifer, for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellData = productData[indexPath.item]
        cell.setProductsData(data: CartViewModel(title: cellData.title,
                                                 price: cellData.price,
                                                 rating: cellData.rating.rate))
        cell.setProductImage(image: productsImages[indexPath.item])
        cell.setAddProductAction { [weak self] in
            guard let self = self else { return }
            self.deleteFromCartButton?(indexPath.item)
        }
        return cell
    }
}

extension CartCollectionViewDataSource: ICartCollectionViewDataSource {
    
    func setProductData(_ data: [DataRepository]) {
        productData = data
    }
    
    func setImageData(_ data: UIImage?) {
        if let image = data {
            productsImages.append(image)
        } else {
            productsImages.append(UIImage(named: "errorImage")!)
        }
    }
    
    func setDeleteFromCartButton(completion: ((Int) -> Void)?) {
        deleteFromCartButton = completion
    }
    
    func removeItem(at index: Int) {
        productData.remove(at: index)
        productsImages.remove(at: index)
    }
    
    func removeAllItems() {
        productData.removeAll()
        productsImages.removeAll()
    }
}
