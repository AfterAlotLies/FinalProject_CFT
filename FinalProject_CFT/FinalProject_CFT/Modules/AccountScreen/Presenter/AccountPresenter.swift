//
//  AccountPresenter.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import Foundation

protocol IAccountPresenter {
    func didLoad(ui: IAccountViewController)
    func loginAction(ui: IAccountViewController, username: String, password: String)
    func notifyErrorToUser(ui: IAccountViewController)
    func logoutAction()
}

class AccountPresenter: IAccountPresenter {
    
    private weak var ui: IAccountViewController?
    private let networkManager: INetworkManager
    
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
    
    func loginAction(ui: IAccountViewController, username: String, password: String) {
        self.ui = ui
        login(username: username, password: password)
    }
    
    func logoutAction() {
        logout()
        ui?.controlProfileViewState(.hidden)
        ui?.controlAuthViewState(.nonHidden)
    }
    
    func notifyErrorToUser(ui: IAccountViewController) {
        self.ui = ui
        ui.showErrorAlert("Fill all field's please")
    }
}

private extension AccountPresenter {
    
    func login(username: String, password: String) {
        networkManager.loginUser(username: username, password: password) { [weak self] key, error in
            guard let self = self else { return }
            if error != nil {
                self.ui?.showErrorAlert("Something gone wrong. Try again")
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
