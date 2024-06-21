//
//  ProductsCollectionViewCell.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 12.06.2024.
//

import UIKit

// MARK: - ICategoriesCollectionViewDataSource
class ProductsCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let rateImage = UIImage(named: "rateImage")
        static let addButtonTitle = "+"
        static let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
        static let topAnchorMargin: CGFloat = 8
        static let addButtonHeightMargin: CGFloat = 30
        static let addButtonWidthMargin: CGFloat = 30
        static let rateImageWidthMargin: CGFloat = 16
        static let rateImageHeightMargin: CGFloat = 16
        static let productImageHeightMargin: CGFloat = 152
        static let productImageWidthMargin: CGFloat = 157
    }
    
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
        imageView.image = Constants.rateImage
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
        button.setTitle(Constants.addButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        
        button.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        
        return button
    }()
    
    static let identifer = String(describing: ProductsCollectionViewCell.self)
    
    private var addProductHandler: (() -> Void)?
    
    // MARK: - Init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func setProductImage(image: UIImage) {
        productImageView.image = image
    }
    
    func setProductsData(data: ProductsViewModel) {
        productNameLabel.text = data.title
        productPriceLabel.text = "\(data.price)$"
        productRateLabel.text = "\(Int(data.rate))"
    }
    
    func setAddProductAction(completion: (() -> Void)?) {
        addProductHandler = completion
    }
    
    func setupCellForDarkTheme() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
    }
    
}

// MARK: - ProductsCollectionViewCell private methods
private extension ProductsCollectionViewCell {
    
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
            productImageView.widthAnchor.constraint(equalToConstant: Constants.productImageWidthMargin),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.productImageHeightMargin),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Constants.topAnchorMargin),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
        ])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            productRateImageView.widthAnchor.constraint(equalToConstant: Constants.rateImageWidthMargin),
            productRateImageView.heightAnchor.constraint(equalToConstant: Constants.rateImageHeightMargin),
            productRateImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productRateImageView.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            productRateImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            productRateLabel.leadingAnchor.constraint(equalTo: productRateImageView.trailingAnchor, constant: 6),
            productRateLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            productRateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.heightAnchor.constraint(equalToConstant: Constants.addButtonHeightMargin),
            addToCartButton.widthAnchor.constraint(equalToConstant: Constants.addButtonWidthMargin),
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
