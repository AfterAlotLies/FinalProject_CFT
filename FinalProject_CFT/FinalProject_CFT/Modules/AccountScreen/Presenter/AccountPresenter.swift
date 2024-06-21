//
//  AccountPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import Foundation

// MARK: - IAccountPresenter protocol
protocol IAccountPresenter {
    func didLoad(ui: IAccountViewController)
    func loginAction(username: String, password: String)
    func notifyErrorToUser()
    func logoutAction()
    func hideKeyboardAction()
}

// MARK: - AccountPresenter
class AccountPresenter: IAccountPresenter {
    
    private enum Constants {
        static let errorFieldAlertMessage = "Fill all field's please"
        static let errorLoginAlertMessage = "Something gone wrong. Try again"
    }
    
    private weak var ui: IAccountViewController?
    private let networkManager: INetworkManager
    
    // MARK: - Init()
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func didLoad(ui: IAccountViewController) {
        self.ui = ui
        if let userToken = KeyStorage.shared.getToken(), !userToken.isEmpty {
            ui.controlAuthViewState(.hidden)
            ui.controlProfileViewState(.nonHidden)
            if let userName = KeyStorage.shared.username, !userName.isEmpty {
                ui.setUserName(userName)
            }
        } else {
            ui.controlAuthViewState(.nonHidden)
            ui.controlProfileViewState(.hidden)
        }
    }
    
    func loginAction(username: String, password: String) {
        login(username: username, password: password)
    }
    
    func logoutAction() {
        logout()
        ui?.controlProfileViewState(.hidden)
        ui?.controlAuthViewState(.nonHidden)
    }
    
    func notifyErrorToUser() {
        ui?.showErrorAlert(Constants.errorFieldAlertMessage)
    }
    
    func hideKeyboardAction() {
        ui?.hideKeyboard()
    }
}

// MARK: - AccountPresenter private methods
private extension AccountPresenter {
    
    func login(username: String, password: String) {
        networkManager.loginUser(username: username, password: password) { [weak self] key, error in
            guard let self = self else { return }
            if error != nil {
                self.ui?.showErrorAlert(Constants.errorLoginAlertMessage)
            } else {
                if let key {
                    KeyStorage.shared.saveToken(token: key.token)
                    KeyStorage.shared.saveUsername(username: username)
                    self.ui?.controlAuthViewState(.hidden)
                    self.ui?.controlProfileViewState(.nonHidden)
                    self.ui?.setUserName(username)
                }
            }
        }
    }
    
    func logout() {
        KeyStorage.shared.deleteToken()
    }
}
