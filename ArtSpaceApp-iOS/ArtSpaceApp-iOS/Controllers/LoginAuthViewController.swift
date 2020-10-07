//
//  LoginAuthViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class LoginAuthViewController: UIViewController {
    
    // MARK: Enums
    enum Font {
        static let title = "SavoyeLetPlain"
        static let button = "Arial-Bold"
    }
    
    enum PlaceholderText {
        static let emailAddress = "Enter Email Address"
        static let password = "Enter Password"
    }
    
    enum ButtonTitle {
        static let loginButton = "Login"
    }
    
    //MARK: Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.text = "ArtSpace"
        label.font = UIFont(name: Font.title, size: 45)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceholderText.emailAddress
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceholderText.password
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var loginAuthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(ButtonTitle.loginButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.button, size: 16)
        button.backgroundColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginAuth), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func handleLoginAuth() {
        
    }

}
