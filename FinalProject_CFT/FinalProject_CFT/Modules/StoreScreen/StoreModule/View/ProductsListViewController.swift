//
//  ProductsListViewController.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - IProductsListViewController protocol
protocol IProductsListViewController: AnyObject {
    func reloadCategoriesCollectionView()
    func reloadProductsCollectionView()
    func setProductsCount(_ count: Int)
    func setLoaderState(state: LoaderState)
    func showNextController(_ viewController: UIViewController)
    func showError(errorMessage: String)
    func showSuccess(successMessage: String)
}

// MARK: - ProductsListViewController
class ProductsListViewController: UIViewController {
    
    private enum Constants {
        static let contollerTitle = "Shop"
        static let errorAlerTitle = "Error"
        static let alertButtonTitle = "OK"
        static let successAlertTitle = "Success!"
    }
    
    private lazy var productsView: ProductsView = {
        let view = ProductsView(categoriesDataSource: categoriesDataSource, productsDataSource: productsDataSource, collectionDelegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var productsControllerCoordinator: ProductsControllerCoordinator?
    private let productsPresenter: ProductsPresenter
    private let categoriesDataSource: CategoriesCollectionViewDataSource
    private let productsDataSource: ProductsCollectionViewDataSource
    
    // MARK: - Init()
    init(productsPresenter: ProductsPresenter, categoriesDataSource: CategoriesCollectionViewDataSource, productsDataSource: ProductsCollectionViewDataSource) {
        self.productsPresenter = productsPresenter
        self.categoriesDataSource = categoriesDataSource
        self.productsDataSource = productsDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        productsPresenter.didLoad(ui: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

// MARK: - ProductsListViewController + IProductsListViewController
extension ProductsListViewController: IProductsListViewController {
    
    func reloadCategoriesCollectionView() {
        productsView.updateCategoriesCollection()
    }
    
    func reloadProductsCollectionView() {
        productsView.updateProductsCollection()
    }
    
    func setProductsCount(_ count: Int) {
        productsView.setCountOfProducts(count)
    }
    
    func setLoaderState(state: LoaderState) {
        switch state {
        case .animating:
            productsView.startLoaderAnimation()
        case .nonAnimating:
            productsView.stopLoaderAnimation()
        }
    }
    
    func showNextController(_ viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError(errorMessage: String) {
        showErrorAlert(error: errorMessage)
    }
    
    func showSuccess(successMessage: String) {
        showSuccessAlert(success: successMessage)
    }

}

// MARK: - ProductsListViewController + ICollectionViewDelegate
extension ProductsListViewController: ICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if productsView.isCategoriesCollection(collectionView: collectionView) {
            productsPresenter.didSelectItem(indexPath.item)
        } else {
            productsPresenter.setupNextController(passingDataIndex: indexPath.item)
        }
    }
}

// MARK: - ProductsListViewController private methods
private extension ProductsListViewController {
    
    func setupController() {
        title = Constants.contollerTitle
        view.backgroundColor = .systemBackground
        view.addSubview(productsView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showErrorAlert(error: String) {
        let alert = UIAlertController(title: Constants.errorAlerTitle, message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.alertButtonTitle, style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func showSuccessAlert(success: String) {
        let alert = UIAlertController(title: Constants.successAlertTitle, message: success, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.alertButtonTitle, style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
