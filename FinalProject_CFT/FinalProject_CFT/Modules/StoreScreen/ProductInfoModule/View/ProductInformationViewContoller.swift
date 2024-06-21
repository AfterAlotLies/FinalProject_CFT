//
//  ProductInformationViewContoller.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 14.06.2024.
//

import UIKit

// MARK: - IProductInformationViewContoller protocol
protocol IProductInformationViewController: AnyObject {
    func setData(data: ProductInfoModel)
    func getActionHandler(completion: (() -> Void)?)
    func showSuccessAlert(successMessage: String)
    func showErrorAlert(errorMessage: String)
}

// MARK: - ProductInformationViewContoller
class ProductInformationViewContoller: UIViewController {
    
    private enum Constants {
        static let errorAlertTitle = "Error"
        static let successAlertTitle = "Success"
        static let alertButtonTitle = "OK"
    }
    
    private lazy var productInfoView: ProductInfoView = {
        let view = ProductInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productsInfoPresenter: ProductsInfoPresenter
    
    // MARK: - Init
    init(productsInfoPresenter: ProductsInfoPresenter) {
        self.productsInfoPresenter = productsInfoPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        productsInfoPresenter.didLoad(ui: self)
    }
}

// MARK: - ProductInformationViewContoller + IProductInformationViewContoller
extension ProductInformationViewContoller: IProductInformationViewController {
    
    func setData(data: ProductInfoModel) {
        productInfoView.setDataToUI(productInfo: data)
    }
    
    func getActionHandler(completion: (() -> Void)?) {
        productInfoView.setAddToCartActionHandler(completion: completion)
    }
    
    func showErrorAlert(errorMessage: String) {
        errorAlert(error: errorMessage)
    }
    
    func showSuccessAlert(successMessage: String) {
        successAlert(success: successMessage)
    }
}

// MARK: - ProductInformationViewContoller private methods
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
    
    func errorAlert(error: String) {
        let alert = UIAlertController(title: Constants.errorAlertTitle, message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.alertButtonTitle, style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func successAlert(success: String) {
        let alert = UIAlertController(title: Constants.successAlertTitle, message: success, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.alertButtonTitle, style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
