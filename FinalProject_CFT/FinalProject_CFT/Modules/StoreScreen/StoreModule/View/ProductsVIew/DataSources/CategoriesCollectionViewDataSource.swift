//
//  CategoriesCollectionViewDataSource.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 12.06.2024.
//

import UIKit

// MARK: - Category enum
private enum Category: String, CaseIterable {
    case gadgets = "Gadget"
    case jewelry = "Jewelry"
    case men = "Men"
    case women = "Women"

    var imageName: String {
        switch self {
        case .gadgets:
            return "electronicsImage"
        case .jewelry:
            return "jeweleryImage"
        case .men:
            return "mensImage"
        case .women:
            return "womenImage"
        }
    }
}

// MARK: - ICategoriesCollectionViewDataSource protocol
protocol ICategoriesCollectionViewDataSource {
    var selectedCell: IndexPath.Element { get set}
    func changeSelectedCell(indexPath: IndexPath.Element)
}

// MARK: - CategoriesCollectionViewDataSource
class CategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var selectedCell: IndexPath.Element = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
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
        
        let category = Category.allCases[indexPath.item]
        cell.setImageToItem(imageName: category.imageName)
        cell.setCategoryName(Categories(categoryName: category.rawValue))
        return cell
    }
}

// MARK: - CategoriesCollectionViewDataSource + ICategoriesCollectionViewDataSource
extension CategoriesCollectionViewDataSource: ICategoriesCollectionViewDataSource {
    
    func changeSelectedCell(indexPath: IndexPath.Element) {
        selectedCell = indexPath
    }
}
