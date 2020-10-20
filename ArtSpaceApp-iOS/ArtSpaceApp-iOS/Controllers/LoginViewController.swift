//
//  LoginAuthViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//
import UIKit
import FirebaseAuth

// MARK: Enums
fileprivate enum TitleText {
    static let appName = "Artspace"
    static let loginButton = "Login"
}

fileprivate enum FontStyle {
    static let savoyeLetPlain = "SavoyeLetPlain"
    static let arialBold = "Arial-Bold"
}

fileprivate enum PlaceholderText {
    static let emailAddress = "Email Address"
    static let password = "Password"
}

fileprivate enum Color {
    static let textColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let backgroundColor = UIColor(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
}

class LoginAuthViewController: UIViewController {
        
    //MARK: UI Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textColor
        label.text = "Login Screen"
        label.font = UIFont(name: FontStyle.savoyeLetPlain, size: 45)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceholderText.emailAddress
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = PlaceholderText.password
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        textField.isSecureTextEntry = false
        textField.autocapitalizationType = .none
        return textField
    }()

    private lazy var loginAuthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TitleText.loginButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStyle.arialBold, size: 16)
        button.backgroundColor = Color.backgroundColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginAuthButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: Private Properties
    private var validateUserCredentials: (email: String, password: String)? {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !email.isEmpty else {
            let alertTitle = "Required"
            let alertMessage = "Please fill in all fields"
            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
            return nil
        }
        return (email, password)
    }
    
    // MARK: Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
    
    private func transitionToMainFeedVC( ){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate,
          let window = sceneDelegate.window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromTop, animations: {
          if FirebaseAuthService.manager.currentUser != nil {
            window.rootViewController = HomeTabBarViewController()
          } else {
            window.rootViewController = { () -> HomeTabBarViewController in
              let searchVC = HomeTabBarViewController()
              return searchVC
            }()
          }
        }, completion: nil)
    }
    
    // MARK: Firebase Methods
    private func handleLoginResponse(withResult result: Result<User, Error>) {
        let alertTitle: String
        let alertMessage: String
        switch result {
        case let .success(user):
          transitionToMainFeedVC()
          print("Logged in user with email \(user.email ?? "no email") and \(user.uid)")
        case let .failure(error):
          alertTitle = "Login Failure"
          alertMessage = "An error occured while logging in: \(error.localizedDescription)"
          presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
        }
    }
    
    private func loginUser(_ sender: UIButton) {
        guard let validCredentials = validateUserCredentials else { return }

        guard validCredentials.email.isValidEmail else {
            let alertTitle = "Error"
            let alertMessage = "Please enter a valid email"
            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
            return
        }
        
        FirebaseAuthService.manager.loginUser(withEmail: validCredentials.email, andPassword: validCredentials.password) { [weak self] (result) in
            self?.handleLoginResponse(withResult: result)
        }
    }
    
    // MARK: objc Methods
    @objc private func loginAuthButtonPressed() {
        loginUser(loginAuthButton)
        print("Login Button Pressed")
    }

    // MARK: UIElement Configuration
    private func configureUIElements() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let itemViews = [titleLabel, emailTextField, passwordTextField, loginAuthButton]
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func constrainUIElelements() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginAuthButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginAuthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginAuthButton.widthAnchor.constraint(equalToConstant: 300),
            loginAuthButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: Extension
extension LoginAuthViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
