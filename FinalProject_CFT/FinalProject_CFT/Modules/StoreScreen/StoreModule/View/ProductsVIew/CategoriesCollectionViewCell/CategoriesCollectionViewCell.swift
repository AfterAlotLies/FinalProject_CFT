//
//  CategoriesCollectionViewCell.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 12.06.2024.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifer = String(describing: CategoriesCollectionViewCell.self)
    
    private let backgroundCellColor: UIColor = UIColor(red: 221.0 / 255.0, green: 224.0 / 255.0, blue: 230.0 / 255.0, alpha: 1)
    private let borderChoosenCellColor: UIColor = UIColor(red: 43.0 / 255.0, green: 57.0 / 255.0, blue: 185.0 / 255.0, alpha: 1)
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.addSubview(categoryImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundCellColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageToItem(imageName: String) {
        categoryImageView.image = UIImage(named: imageName)
    }
    
    func setCategoryName(_ name: Categories) {
        categoryNameLabel.text = name.categoryName
    }
    
    func setChoosenCell() {
        imageBackgroundView.layer.borderColor = borderChoosenCellColor.cgColor
    }
    
    func setUnchoosenCell() {
        imageBackgroundView.layer.borderColor = UIColor.clear.cgColor
    }
}

private extension CategoriesCollectionViewCell {
    
    func setupItem() {
        addSubview(imageBackgroundView)
        addSubview(categoryNameLabel)
        
        setupCell()
        setupConstraints()
    }
    
    func setupCell() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            imageBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            imageBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
        ])
        
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: imageBackgroundView.centerXAnchor),
            categoryImageView.centerYAnchor.constraint(equalTo: imageBackgroundView.centerYAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 34),
            categoryImageView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 8),
            categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoryNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
