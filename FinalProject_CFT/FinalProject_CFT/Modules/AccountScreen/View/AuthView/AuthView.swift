//
//  AuthView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import UIKit

class AuthView: UIView {
    
    private lazy var shopLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoImage")
        return imageView
    }()
    
    private lazy var welcomeBackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome back!"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Your username here..."
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(touchUpInsideTextField), for: .editingDidEnd)
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.leftViewMode = .always
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Your password here..."
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(touchUpInsideTextField), for: .editingDidEnd)
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.leftViewMode = .always
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        
        let hideButton = UIButton(type: .custom)
        hideButton.setImage(UIImage(named: "eyeImage"), for: .normal)
        hideButton.contentMode = .center
        hideButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        imageContainerView.addSubview(hideButton)
        hideButton.center = imageContainerView.center
        hideButton.addTarget(self, action: #selector(hideButtonAction), for: .touchUpInside)
        
        textField.rightView = imageContainerView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = buttonBackgroundColor
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.clear.cgColor
        
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
    private var isPasswordHidden: Bool = true
    private var actionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getUsername() -> String? {
        if let username = usernameTextField.text, !username.isEmpty {
            return username
        } else {
            return nil
        }
    }
    
    func getPassword() -> String? {
        if let password = passwordTextField.text, !password.isEmpty {
            return password
        } else {
            return nil
        }
    }
    
    func setLoginButton(tapHandler: (() -> Void)?) {
        actionHandler = tapHandler
    }
}

private extension AuthView {
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(shopLogoImageView)
        addSubview(welcomeBackLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shopLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            shopLogoImageView.widthAnchor.constraint(equalToConstant: 74),
            shopLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            shopLogoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: shopLogoImageView.bottomAnchor, constant: 16),
            welcomeBackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            welcomeBackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: welcomeBackLabel.bottomAnchor, constant: 24),
            usernameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            usernameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            usernameTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            passwordTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc
    func loginButtonAction() {
        actionHandler?()
    }
    
    @objc
    func hideButtonAction() {
        if isPasswordHidden {
            passwordTextField.isSecureTextEntry = false
            isPasswordHidden = false
        } else {
            passwordTextField.isSecureTextEntry = true
            isPasswordHidden = true
        }
    }
    
    @objc
    func textFieldDidChanged(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            textField.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
    
    @objc
    func touchUpInsideTextField(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
