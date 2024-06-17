//
//  ProductsListViewController.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

enum LoaderState {
    case animating
    case nonAnimating
}

protocol IProductsListViewController: AnyObject {
    func reloadCategoriesCollectionView()
    func reloadProductsCollectionView()
    func setProductsCount(_ count: Int)
    func setLoaderState(state: LoaderState)
    func showNextController(_ viewController: UIViewController)
    func showError(errorMessage: String)
}

class ProductsListViewController: UIViewController {
    
    private lazy var productsView: ProductsView = {
        let view = ProductsView(categoriesDataSource: categoriesDataSource, productsDataSource: productsDataSource, collectionDelegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var productsControllerCoordinator: ProductsControllerCoordinator?
    private let productsPresenter: ProductsPresenter
    private let categoriesDataSource: CategoriesCollectionViewDataSource
    private let productsDataSource: ProductsCollectionViewDataSource
    
    init(productsPresenter: ProductsPresenter, categoriesDataSource: CategoriesCollectionViewDataSource, productsDataSource: ProductsCollectionViewDataSource) {
        self.productsPresenter = productsPresenter
        self.categoriesDataSource = categoriesDataSource
        self.productsDataSource = productsDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        productsPresenter.didLoad(ui: self)
    }
}

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
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError(errorMessage: String) {
        showErrorAlert(error: errorMessage)
    }
}

extension ProductsListViewController: ICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if productsView.isCategoriesCollection(collectionView: collectionView) {
            productsPresenter.didSelectItem(indexPath.item)
        } else {
            productsPresenter.setupNextController(passingDataIndex: indexPath.item)
        }
    }
}

private extension ProductsListViewController {
    
    func setupController() {
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
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
