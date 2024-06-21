//
//  CartView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 19.06.2024.
//

import UIKit

// MARK: - CartView
class CartView: UIView {
    
    private enum Constants {
        static let countOfProductsText = "0 Products in your cart"
        static let notificationText = "You are not logged in to see your cart"
    }
    
    private lazy var cartCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createProductsCollectionLayout())
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = cartDataSource
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var countOfProductsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.countOfProductsText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = Constants.notificationText
        return label
    }()
    
    private let cartDataSource: CartCollectionViewDataSource
    
    // MARK: - Init()
    init(frame: CGRect, cartDataSource: CartCollectionViewDataSource) {
        self.cartDataSource = cartDataSource
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func reloadCartCollection() {
        cartCollectionView.reloadData()
    }
    
    func setCountProducts(_ count: Int) {
        countOfProductsLabel.text = "\(count) Products in your cart"
    }
    
    func setCountOfProductsLabelState(_ state: UiState) {
        switch state {
        case .hidden:
            countOfProductsLabel.isHidden = true
        case .nonHidden:
            countOfProductsLabel.isHidden = false
        }
    }
    
    func setNotificationLabelState(_ state: UiState) {
        switch state {
        case .hidden:
            notificationLabel.isHidden = true
        case .nonHidden:
            notificationLabel.isHidden = false
        }
    }
    
    func setCartCollectionState(_ state: UiState) {
        switch state {
        case .hidden:
            cartCollectionView.isHidden = true
        case .nonHidden:
            cartCollectionView.isHidden = false
        }
    }
}

// MARK: - CartView private methods
private extension CartView {
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(countOfProductsLabel)
        addSubview(cartCollectionView)
        addSubview(notificationLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            countOfProductsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            countOfProductsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            countOfProductsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            cartCollectionView.topAnchor.constraint(equalTo: countOfProductsLabel.bottomAnchor, constant: 8),
            cartCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cartCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cartCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            notificationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            notificationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
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
