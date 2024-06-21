//
//  ProfileView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 18.06.2024.
//

import UIKit

// MARK: - ProfileView
class ProfileView: UIView {
    
    private enum Constants {
        static let introductionLabelText = "There is nothing to do but we are in proccess! Now u can add products to your cart"
        static let logoutButtonTitle = "Log Out"
        static let logoutButtonBackgroundColor: UIColor = UIColor(red: 242.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
        static let topAnchorMargin: CGFloat = 16
        static let leadingAnchorMargin: CGFloat = 16
        static let trailingAnchorMargin: CGFloat = -16
    }
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var introductionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.introductionLabelText
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.logoutButtonTitle, for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = Constants.logoutButtonBackgroundColor
        
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        return button
    }()
    
    private var logoutActionHandler: (() -> Void)?
    
    // MARK: - Init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func setLogoutAction(completion: (() -> Void)?) {
        logoutActionHandler = completion
    }
    
    func setUserName(username: String) {
        usernameLabel.text = "\(username) Profile account"
    }
}

// MARK: - ProfileView private methods
private extension ProfileView {
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(usernameLabel)
        addSubview(dividerView)
        addSubview(introductionLabel)
        addSubview(logoutButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topAnchorMargin),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: Constants.topAnchorMargin),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            introductionLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 36),
            introductionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
            introductionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingAnchorMargin),
            logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingAnchorMargin),
            logoutButton.heightAnchor.constraint(equalToConstant: 67),
            logoutButton.topAnchor.constraint(greaterThanOrEqualTo: introductionLabel.bottomAnchor, constant: Constants.topAnchorMargin)
        ])
    }
    
    @objc
    func logoutAction() {
        logoutActionHandler?()
    }
}
