//
//  ProductInfoView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 16.06.2024.
//

import UIKit

class ProductInfoView: UIView {
    
    private let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
    
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
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = buttonBackgroundColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataToUI(productInfo: ProductInfoModel) {
        if let image = productInfo.image {
            productImageView.image = image
        } else {
            productImageView.image = UIImage(named: "errorImage")
        }
        productNameLabel.text = productInfo.title
        productRateLabel.text = "\(productInfo.rating)"
        productPriceLabel.text = "\(productInfo.price)$"
        productDescriptionView.text = productInfo.description
    }
}

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
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 250),
            productImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            productNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            productRateLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            productRateLabel.leadingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            productRateImageView.centerYAnchor.constraint(equalTo: productRateLabel.centerYAnchor),
            productRateImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            productRateImageView.leadingAnchor.constraint(equalTo: productRateLabel.trailingAnchor, constant: 8),
            productRateImageView.widthAnchor.constraint(equalToConstant: 16),
            productRateImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            viewDivider.heightAnchor.constraint(equalToConstant: 1),
            viewDivider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewDivider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewDivider.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            productDescriptionView.topAnchor.constraint(equalTo: viewDivider.bottomAnchor, constant: 16),
            productDescriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            productDescriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: productDescriptionView.bottomAnchor, constant: 8),
            addToCartButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  16),
            addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            addToCartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
