//
//  ProductInformationViewContoller.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 14.06.2024.
//

import UIKit

protocol IProductInformationViewContoller: AnyObject {
    func setData(data: ProductInfoModel)
}

class ProductInformationViewContoller: UIViewController {
    
    private lazy var productInfoView: ProductInfoView = {
        let view = ProductInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productsInfoPresenter: ProductsInfoPresenter
    
    init(productsInfoPresenter: ProductsInfoPresenter) {
        self.productsInfoPresenter = productsInfoPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        productsInfoPresenter.didLoad(ui: self)
    }
}

extension ProductInformationViewContoller: IProductInformationViewContoller {
    
    func setData(data: ProductInfoModel) {
        productInfoView.setDataToUI(productInfo: data)
    }
}

private extension ProductInformationViewContoller {
    
    func setupController() {
        view.backgroundColor = .systemBackground

        view.addSubview(productInfoView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
