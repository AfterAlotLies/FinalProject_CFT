//
//  ProfileView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 18.06.2024.
//

import UIKit

class ProfileView: UIView {
    
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
        label.text = "There is nothing to do but we are in proccess! Now u can add products to your cart"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = logoutButtonBackgroundColor
        
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        return button
    }()
    
    private let logoutButtonBackgroundColor: UIColor = UIColor(red: 242.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
    private var logoutActionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLogoutAction(completion: (() -> Void)?) {
        logoutActionHandler = completion
    }
    
    func setUserName(username: String) {
        usernameLabel.text = "\(username) Profile account"
    }
}

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
            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            introductionLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 36),
            introductionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            introductionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 67),
            logoutButton.topAnchor.constraint(greaterThanOrEqualTo: introductionLabel.bottomAnchor, constant: 16)
        ])
    }
    
    @objc
    func logoutAction() {
        logoutActionHandler?()
    }
}
