//
//  LoginAuthViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginAuthViewController: UIViewController {
    
    // MARK: Enums
    enum Font {
        static let title = "SavoyeLetPlain"
        static let button = "Arial-Bold"
    }
    
    enum PlaceholderText {
        static let emailAddress = "Enter Email Address"
        static let password = "Enter Password"
        static let required = "Required"
        static let fillAllFields = "Please fill in all fields"
    }
    
    enum ButtonTitle {
        static let loginButton = "Login"
    }
    
    //MARK: UI Properties
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
        button.addTarget(self, action: #selector(loginAuthButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: Private Properties
    private var validateUserCredentials: (email: String, password: String)? {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !email.isEmpty else {
            let alertTitle = PlaceholderText.required
            let alertMessage = PlaceholderText.fillAllFields
            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
            return nil
        }
        return (email, password)
    }
    
    // MARK: Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        constrainUIElelements()
        createDismissKeyboardTapGesture()
    }
    
    // MARK: Private Functions
    private func presentGenericAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Firebase Methods
    private func handleLoginResponse(withResult result: Result<User, Error>) {
//        let alertTitle: String
//        let alertMessage: String
//        switch result {
//        case let .success(user):
//          transitionToSearchVC()
//          print("Logged in user with email \(user.email ?? "no email") and \(user.uid)")
//        case let .failure(error):
//          alertTitle = "Login Failure"
//          alertMessage = "An error occured while logging in: \(error.localizedDescription)"
//          presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
//        }
    }
    
    private func loginUser(_ sender: UIButton) {
//        guard let validCredentials = validateUserCredentials else { return }
//
//        guard validCredentials.email.isValidEmail else {
//            let alertTitle = "Error"
//            let alertMessage = "Please enter a valid email"
//            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
//            return
//        }
//        FirebaseAuthService.manager.loginUser(withEmail: validCredentials.email,
//                                              andPassword: validCredentials.password) { [weak self ](result) in
//            self?.handleLoginResponse(withResult: result)
//        }
    }
    
    // MARK: objc Methods
    @objc func loginAuthButtonPressed() {
        loginUser(loginAuthButton)
    }

    // MARK: UI Element Constraints
    private func configureUIElements() {
        let itemViews = [titleLabel, emailTextField, passwordTextField, loginAuthButton]
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func constrainUIElelements() {
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // emailTextField
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // loginAuthButton
            loginAuthButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginAuthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginAuthButton.widthAnchor.constraint(equalToConstant: 300),
            loginAuthButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
