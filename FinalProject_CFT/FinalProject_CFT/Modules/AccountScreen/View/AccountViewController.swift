//
//  AccountViewController.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import UIKit

enum ViewState {
    case hidden
    case nonHidden
}

protocol IAccountViewController: AnyObject {
    func showErrorAlert(_ error: String)
    func controlAuthViewState(_ state: ViewState)
    func controlProfileViewState(_ state: ViewState)
    func setUserName(_ name: String)
}

class AccountViewController: UIViewController {
    
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
    
    init(accountPresenter: AccountPresenter) {
        self.accountPresenter = accountPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        accountPresenter.didLoad(ui: self)
        userLogout()
        userLogin()
    }
}

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
}

private extension AccountViewController {
    
    func setupController() {
        title = "Account"
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
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func userLogin() {
        authView.setLoginButton { [weak self] in
            guard let self = self else { return }
            if let username = self.authView.getUsername(),
               let password = self.authView.getPassword() {
                self.accountPresenter.loginAction(ui: self,username: username, password: password)
            } else {
                self.accountPresenter.notifyErrorToUser(ui: self)
            }
        }
    }
    
    func userLogout() {
        profileView.setLogoutAction { [weak self] in
            guard let self = self else { return }
            self.accountPresenter.logoutAction()
        }
    }
}
