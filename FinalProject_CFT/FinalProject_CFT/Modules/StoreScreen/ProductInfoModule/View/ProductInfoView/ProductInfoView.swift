//
//  ProductInfoView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 16.06.2024.
//

import UIKit

// MARK: - ProductInfoView
class ProductInfoView: UIView {
    
    private enum Constants {
        static let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
        static let rateImage = UIImage(named: "rateImage")
        static let addButtonTitle = "Add to cart"
        static let errorImage = UIImage(named: "errorImage")
        static let productImageHeightMargin: CGFloat = 250
        static let productImageWidthMargin: CGFloat = 250
        static let topAnchorMargin: CGFloat = 16
        static let leadingAnchorMargin: CGFloat = 16
        static let trailingAnchorMargin: CGFloat = -16
        static let rateImageHeightMargin: CGFloat = 16
        static let rateImageWidthMargin: CGFloat = 16
    }
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 23)
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var viewDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var productDescriptionView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.addButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(makeAddToCartButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var addToCartActionHandler: (() -> Void)?
    
    // MARK: - Init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func setDataToUI(productInfo: ProductInfoModel) {
        if let image = productInfo.image {
            productImageView.image = image
        } else {
            productImageView.image = Constants.errorImage
        }
        productNameLabel.text = productInfo.title
        productRateLabel.text = "\(productInfo.rating)"
        productPriceLabel.text = "\(productInfo.price)$"
        productDescriptionView.text = productInfo.description
    }
    
    func setAddToCartActionHandler(completion: (() -> Void)?) {
        addToCartActionHandler = completion
    }
}

// MARK: - ProductInfoView private methods
private extension ProductInfoView {
    
    func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productRateImageView)
        addSubview(productRateLabel)
        addSubview(viewDivider)
        addSubview(productDescriptionView)
        addSubview(addToCartButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topAnchorMargin),
            productImageView.widthAnchor.constraint(equalToConstant: Constants.productImageWidthMargin),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.productImageHeightMargin)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: Constants.topAnchorMargin),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin)
        ])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
        ])
        
        NSLayoutConstraint.activate([
            productRateLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            productRateLabel.leadingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor, constant: Constants.leadingAnchorMargin),
        ])
        
        NSLayoutConstraint.activate([
            productRateImageView.centerYAnchor.constraint(equalTo: productRateLabel.centerYAnchor),
            productRateImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            productRateImageView.leadingAnchor.constraint(equalTo: productRateLabel.trailingAnchor, constant: 8),
            productRateImageView.widthAnchor.constraint(equalToConstant: Constants.rateImageWidthMargin),
            productRateImageView.heightAnchor.constraint(equalToConstant: Constants.rateImageHeightMargin)
        ])
        
        NSLayoutConstraint.activate([
            viewDivider.heightAnchor.constraint(equalToConstant: 1),
            viewDivider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewDivider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewDivider.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: Constants.topAnchorMargin)
        ])
        
        NSLayoutConstraint.activate([
            productDescriptionView.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: Constants.topAnchorMargin),
            productDescriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
            productDescriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin),
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productDescriptionView.bottomAnchor, constant: 8),
            addToCartButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  Constants.leadingAnchorMargin),
            addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin),
            addToCartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func makeAddToCartButtonAction() {
        addToCartActionHandler?()
    }
}
