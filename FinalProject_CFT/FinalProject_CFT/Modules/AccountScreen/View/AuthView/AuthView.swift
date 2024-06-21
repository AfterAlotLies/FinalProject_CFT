//
//  AuthView.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 17.06.2024.
//

import UIKit

// MARK: - AuthView
class AuthView: UIView {
    
    private enum Constants {
        static let logoImage = UIImage(named: "logoImage")
        static let welcomeBackLabelText = "Welcome back!"
        static let usernameTextFieldPlaceHolder = "Your username here..."
        static let passwordTextFieldPlaceHolder = "Your password here..."
        static let hideButtonImage = UIImage(named: "eyeImage")
        static let buttonBackgroundColor: UIColor = UIColor(red: 83.0 / 255.0, green: 177.0 / 255.0, blue: 117.0 / 255.0, alpha: 1)
        static let shopLogoImageWidthMargin: CGFloat = 74
        static let shopLogoImageHeightMargin: CGFloat = 100
        static let topAnchorMargin: CGFloat = 16
    }
    
    private lazy var shopLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.logoImage
        return imageView
    }()
    
    private lazy var welcomeBackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.welcomeBackLabelText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = Constants.usernameTextFieldPlaceHolder
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
        textField.placeholder = Constants.passwordTextFieldPlaceHolder
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
        hideButton.setImage(Constants.hideButtonImage, for: .normal)
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
        button.backgroundColor = Constants.buttonBackgroundColor
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.clear.cgColor
        
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private var isPasswordHidden: Bool = true
    private var actionHandler: (() -> Void)?
    
    // MARK: - Init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(AppErrors.fatalErrorMessage)
    }
    
    func getUsername() -> String? {
        if let username = usernameTextField.text, !username.isEmpty {
            return username.lowercased()
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

// MARK: - AuthView private methods
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
            shopLogoImageView.heightAnchor.constraint(equalToConstant: Constants.shopLogoImageHeightMargin),
            shopLogoImageView.widthAnchor.constraint(equalToConstant: Constants.shopLogoImageWidthMargin),
            shopLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            shopLogoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topAnchorMargin),
        ])
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: shopLogoImageView.bottomAnchor, constant: Constants.topAnchorMargin),
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
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: Constants.topAnchorMargin),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            passwordTextField.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: Constants.topAnchorMargin),
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
