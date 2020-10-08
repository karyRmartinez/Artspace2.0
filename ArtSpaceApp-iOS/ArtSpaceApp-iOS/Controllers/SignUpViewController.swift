//
//  SignUpViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/7/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupAuthViewController: UIViewController {
    enum Text {
        static let createAccount  = "ArtSpace: Create Account"
        static let arialFont = "Arial"
        static let verdanaFont = "Verdana"
        static let verdanaBoldFont = "Verdana-Bold"
        static let createButton = "Create Account"
    }
    
    enum UserDetails {
        static let username =  "User Name"
        static let email = "Enter Email"
        static let password =  "Enter Password"
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Text.createAccount
        label.font = UIFont(name: Text.arialFont, size: 28)
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var UserNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.username
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.email
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.password
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        //textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.createButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Text.verdanaBoldFont, size: 14)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                UserNameTextField,
                emailTextField,
                passwordTextField,
                createButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: Obj-C Methods
    @objc func trySignUp() {
       
     
     }
     
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setSubviews()
        setTitleLabelConstraints()
        setupStackViewConstraints()
    }
    
    //MARK: Private methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
 //MARK: UI Contraints configuration
    private func setSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(stackView)
    }

    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)])
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
