//
//  CartCollectionViewCell.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 20.06.2024.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var productRateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rateImage")
        return imageView
    }()
    
    private lazy var productRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        
        button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        return button
    }()
    
    static let identifer = String(describing: CartCollectionViewCell.self)
    
    private let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
    private var addProductHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductImage(image: UIImage) {
        productImageView.image = image
    }
    
    func setProductsData(data: CartViewModel) {
        productNameLabel.text = data.title
        productPriceLabel.text = "\(data.price)$"
        productRateLabel.text = "\(Int(data.rating))"
    }
    
    func setAddProductAction(completion: (() -> Void)?) {
        addProductHandler = completion
    }
    
}

private extension CartCollectionViewCell {
    
    func setupItem() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productRateImageView)
        addSubview(productRateLabel)
        addSubview(addToCartButton)
        
        setupCell()
        setupConstraints()
    }
    
    func setupCell() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 157),
            productImageView.heightAnchor.constraint(equalToConstant: 152),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
        ])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            productRateImageView.widthAnchor.constraint(equalToConstant: 16),
            productRateImageView.heightAnchor.constraint(equalToConstant: 16),
            productRateImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productRateImageView.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 8),
            productRateImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            productRateLabel.leadingAnchor.constraint(equalTo: productRateImageView.trailingAnchor, constant: 6),
            productRateLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 8),
            productRateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            addToCartButton.widthAnchor.constraint(equalToConstant: 30),
            addToCartButton.centerYAnchor.constraint(equalTo: productRateLabel.centerYAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: productRateLabel.trailingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    @objc
    func addToCartAction() {
        addProductHandler?()
    }
}

