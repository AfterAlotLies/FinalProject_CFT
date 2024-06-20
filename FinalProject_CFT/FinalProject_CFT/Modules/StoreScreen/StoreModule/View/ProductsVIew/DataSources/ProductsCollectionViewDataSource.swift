//
//  ProductsCollectionViewDataSource.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 13.06.2024.
//

import UIKit

protocol IProductsCollectionViewDataSource {
    func addImage(image: UIImage?)
    func addProducts(data: [DataRepository])
    func removeItems()
    func setAddToCartButton(completion: ((Int) -> Void)?)
}

class ProductsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var addToCartButton: ((Int) -> Void)?
    private var imagesArray = [UIImage]()
    private var productsData = [DataRepository]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.identifer, for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellData = productsData[indexPath.item]
        cell.setProductImage(image: imagesArray[indexPath.item])
        cell.setProductsData(data: ProductsViewModel(title: cellData.title,
                                                     price: cellData.price,
                                                     rate: cellData.rating.rate))
        
        
        cell.setAddProductAction { [weak self] in
            guard let self = self else { return }
            self.addToCartButton?(indexPath.item)
        }
        
        return cell
    }
}

extension ProductsCollectionViewDataSource : IProductsCollectionViewDataSource {
    
    func addImage(image: UIImage?) {
        if let image {
            imagesArray.append(image)
        } else {
            imagesArray.append(UIImage(named: "errorImage")!)
        }
    }
    
    func addProducts(data: [DataRepository]) {
        productsData = data
    }
    
    func removeItems() {
        productsData.removeAll()
        imagesArray.removeAll()
    }
    
    func setAddToCartButton(completion: ((Int) -> Void)?) {
        addToCartButton = completion
    }
    
}
