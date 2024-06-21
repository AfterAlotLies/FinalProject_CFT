//
//  ProductsView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - ICollectionViewDelegate protocol
protocol ICollectionViewDelegate: UICollectionViewDelegate {}

// MARK: - ProductsView
class ProductsView: UIView {
    
    private lazy var caterogiesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCategoriesCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CategoriesCollectionViewCell.self,
                            forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifer)
        collection.dataSource = categoriesDataSource
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var productsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var productsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createProductsCollectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProductsCollectionViewCell.self,
                            forCellWithReuseIdentifier: ProductsCollectionViewCell.identifer)
        collection.dataSource = productsDataSource
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var loaderIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .black
        return indicator
    }()
    
    private let categoriesDataSource: CategoriesCollectionViewDataSource
    private let productsDataSource: ProductsCollectionViewDataSource
    private weak var collectionDelegate: ICollectionViewDelegate?
    
    // MARK: - Init()
    init(categoriesDataSource: CategoriesCollectionViewDataSource, productsDataSource: ProductsCollectionViewDataSource, collectionDelegate: ICollectionViewDelegate) {
        self.categoriesDataSource = categoriesDataSource
        self.productsDataSource = productsDataSource
        super.init(frame: .zero)
        self.caterogiesCollection.delegate = collectionDelegate
        self.productsCollection.delegate = collectionDelegate
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func updateCategoriesCollection() {
        caterogiesCollection.reloadData()
    }
    
    func updateProductsCollection() {
        productsCollection.reloadData()
    }
    
    func setCountOfProducts(_ count: Int) {
        productsCountLabel.text = "\(count) Products"
    }
    
    func startLoaderAnimation() {
        productsCollection.isHidden = true
        productsCountLabel.isHidden = true
        loaderIndicator.isHidden = false
        loaderIndicator.startAnimating()
    }
    
    func stopLoaderAnimation() {
        productsCollection.isHidden = false
        productsCountLabel.isHidden = false
        loaderIndicator.stopAnimating()
        loaderIndicator.isHidden = true
    }
    
    func isCategoriesCollection(collectionView: UICollectionView) -> Bool {
        if collectionView == caterogiesCollection {
            return true
        } else {
            return false
        }
    }
}

// MARK: - ProductsView private methods
private extension ProductsView {
    
    func setupView() {
        backgroundColor = .clear
        addSubview(caterogiesCollection)
        addSubview(productsCountLabel)
        addSubview(productsCollection)
        addSubview(loaderIndicator)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            caterogiesCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            caterogiesCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            caterogiesCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            caterogiesCollection.heightAnchor.constraint(equalToConstant: 92)
        ])
        
        NSLayoutConstraint.activate([
            productsCountLabel.topAnchor.constraint(equalTo: caterogiesCollection.bottomAnchor, constant: 16),
            productsCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            productsCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
        
        NSLayoutConstraint.activate([
            productsCollection.topAnchor.constraint(equalTo: productsCountLabel.bottomAnchor, constant: 12),
            productsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loaderIndicator.centerXAnchor.constraint(equalTo: productsCollection.centerXAnchor),
            loaderIndicator.centerYAnchor.constraint(equalTo: productsCollection.centerYAnchor)
        ])
    }
    
    func createCategoriesCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 64, height: 92)
        layout.minimumLineSpacing = 35
        return layout
    }
    
    func createProductsCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 270)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return layout
    }
}
