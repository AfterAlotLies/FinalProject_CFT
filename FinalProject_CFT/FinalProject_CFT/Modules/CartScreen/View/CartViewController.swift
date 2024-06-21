//
//  CartViewController.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - ICartViewController protocol
protocol ICartViewController: AnyObject {
    func reloadCollection()
    func getCountProducts(_ count: Int)
    func getCountProductsLabelState(_ state: UiState)
    func getNotificationLabelState(_ state: UiState)
    func getCartCollectionState(_ state: UiState)
}

// MARK: - CartViewController
class CartViewController: UIViewController {
    
    private enum Constants {
        static let controllerTitle = "Cart"
    }
    
    private lazy var cartView: CartView = {
        let view = CartView(frame: .zero, cartDataSource: cartDataSource)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var carControllerCoordinator: CartControllerCoordinator?
    private let cartDataSource: CartCollectionViewDataSource
    private let cartPresenter: CartPresenter
    
    // MARK: - Init()
    init(cartDataSource: CartCollectionViewDataSource, cartPresenter: CartPresenter) {
        self.cartDataSource = cartDataSource
        self.cartPresenter = cartPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        cartPresenter.didLoad(ui: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartPresenter.willLoad(ui: self)
    }
}

// MARK: - CartViewController + ICartViewController
extension CartViewController: ICartViewController {
    
    func reloadCollection() {
        cartView.reloadCartCollection()
    }
    
    func getCountProducts(_ count: Int) {
        cartView.setCountProducts(count)
    }
    
    func getCountProductsLabelState(_ state: UiState) {
        switch state {
        case .hidden:
            cartView.setCountOfProductsLabelState(.hidden)
        case .nonHidden:
            cartView.setCountOfProductsLabelState(.nonHidden)
        }
    }
    
    func getCartCollectionState(_ state: UiState) {
        switch state {
        case .hidden:
            cartView.setCartCollectionState(.hidden)
        case .nonHidden:
            cartView.setCartCollectionState(.nonHidden)
        }
    }
    
    func getNotificationLabelState(_ state: UiState) {
        switch state {
        case .hidden:
            cartView.setNotificationLabelState(.hidden)
        case .nonHidden:
            cartView.setNotificationLabelState(.nonHidden)
        }
    }
}

// MARK: - CartViewController private methods
private extension CartViewController {
    
    func setupController() {
        title = Constants.controllerTitle
        view.backgroundColor = .systemBackground
        
        view.addSubview(cartView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
