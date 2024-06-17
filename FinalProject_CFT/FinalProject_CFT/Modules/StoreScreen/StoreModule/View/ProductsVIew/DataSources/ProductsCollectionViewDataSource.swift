//
//  ProductsCollectionViewDataSource.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 13.06.2024.
//

import UIKit

protocol IProductsCollectionViewDataSource {
    func addImage(image: UIImage)
    func addProducts(data: [DataRepository])
    func removeItems()
}

class ProductsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
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
        return cell
        
    }
}

extension ProductsCollectionViewDataSource : IProductsCollectionViewDataSource {
    
    func addImage(image: UIImage) {
        imagesArray.append(image)
    }
    
    func addProducts(data: [DataRepository]) {
        productsData = data
    }
    
    func removeItems() {
        productsData.removeAll()
        imagesArray.removeAll()
    }
}
