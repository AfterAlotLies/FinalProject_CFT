//
//  AccountViewController.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

// MARK: - IAccountViewController protocol
protocol IAccountViewController: AnyObject {
    func showErrorAlert(_ error: String)
    func controlAuthViewState(_ state: ViewState)
    func controlProfileViewState(_ state: ViewState)
    func setUserName(_ name: String)
    func hideKeyboard()
}

// MARK: - AccountViewController
class AccountViewController: UIViewController {
    
    private enum Constants {
        static let controllerTitle = "Account"
        static let alertErrorTitle = "Error"
        static let alertButtonTitle = "OK"
    }
    
    private lazy var authView: AuthView = {
        let view = AuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var accountControllerCoordinator: AccountControllerCoordinator?
    private let accountPresenter: AccountPresenter
    
    // MARK: - Init()
    init(accountPresenter: AccountPresenter) {
        self.accountPresenter = accountPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        accountPresenter.didLoad(ui: self)
        userLogout()
        userLogin()
        setupHideKeyboardGesture()
    }
}

// MARK: - AccountViewController + IAccountViewController
extension AccountViewController: IAccountViewController {
    
    func showErrorAlert(_ error: String) {
        errorAlert(message: error)
    }
    
    func hideAuthView() {
        authView.isHidden = true
    }
    
    func controlAuthViewState(_ state: ViewState) {
        switch state {
        case .hidden:
            authView.isHidden = true
        case .nonHidden:
            authView.isHidden = false
        }
    }
    
    func controlProfileViewState(_ state: ViewState) {
        switch state {
        case .hidden:
            profileView.isHidden = true
        case .nonHidden:
            profileView.isHidden = false
        }
    }
    
    func setUserName(_ name: String) {
        profileView.setUserName(username: name)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AccountViewController private methods
private extension AccountViewController {
    
    func setupController() {
        title = Constants.controllerTitle
        view.backgroundColor = .systemBackground
        
        view.addSubview(authView)
        view.addSubview(profileView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            authView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            authView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            authView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            authView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func errorAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertErrorTitle, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Constants.alertButtonTitle, style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func userLogin() {
        authView.setLoginButton { [weak self] in
            guard let self = self else { return }
            if let username = self.authView.getUsername(),
               let password = self.authView.getPassword() {
                self.accountPresenter.loginAction(username: username, password: password)
            } else {
                self.accountPresenter.notifyErrorToUser()
            }
        }
    }
    
    func userLogout() {
        profileView.setLogoutAction { [weak self] in
            guard let self = self else { return }
            self.accountPresenter.logoutAction()
        }
    }
    
    func setupHideKeyboardGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userActionOnView))
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    func userActionOnView() {
        accountPresenter.hideKeyboardAction()
    }
}
