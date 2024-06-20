//
//  CategoriesCollectionViewDataSource.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 12.06.2024.
//

import UIKit

protocol ICategoriesCollectionViewDataSource {
    var selectedCell: IndexPath.Element { get set}
    func changeSelectedCell(indexPath: IndexPath.Element)
}

class CategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var selectedCell: IndexPath.Element = 0
    private let categoriesImageArray = ["electronicsImage", "jeweleryImage", "mensImage", "womenImage"]
    private let categoriesArray = ["Gadget", "Jewelery", "Men", "Women"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifer, for: indexPath) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.item == selectedCell {
            cell.setChoosenCell()
        } else {
            cell.setUnchoosenCell()
        }
        
        cell.setImageToItem(imageName: categoriesImageArray[indexPath.item])
        
        cell.setCategoryName(Categories(categoryName: categoriesArray[indexPath.item]))
        return cell
    }
}

extension CategoriesCollectionViewDataSource: ICategoriesCollectionViewDataSource {
    
    func changeSelectedCell(indexPath: IndexPath.Element) {
        selectedCell = indexPath
    }
}
