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
  internal enum Text {
        static let createAccount  = "ArtSpace: Create Account"
        static let arialFont = "Arial"
        static let verdanaFont = "Verdana"
        static let verdanaBoldFont = "Verdana-Bold"
        static let createButton = "Create Account"
    }
    
   internal enum UserDetails {
        static let username =  "User Name"
        static let email = "Enter Email"
        static let password =  "Enter Password"
    }
    
   private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Text.createAccount
        label.font = UIFont(name: Text.arialFont, size: 28)
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
  private lazy var UserNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.username
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.email
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }()
    
   private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = UserDetails.password
        textField.font = UIFont(name: Text.verdanaFont, size: 14)
        textField.backgroundColor = .lightText
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        //textField.isSecureTextEntry = true
        return textField
    }()
    
   private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Text.createButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Text.verdanaBoldFont, size: 14)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
   private lazy var stackView: UIStackView = {
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
   @objc private func signUpButtonPressed() {
       if !validateFields() {
                return
     
     }
   signUpUser(createButton)
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
    private func showErrorAlert(title: String, message: String) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func validateFields() -> Bool {
          guard let _ =  UserNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
     showErrorAlert(title: "Error", message: "Please fill out all fields.")
              return false
          }
          
          guard email.isValidEmail else {
    showErrorAlert(title: "Error", message: "Please enter a valid email")
              return false
          }
          
          guard password.isValidPassword else {
    showErrorAlert(title: "Error", message: "Please enter a valid password. Passwords must have at least 8 characters.")
              return false
          }
          
          return true
      }
    
 
    
    private func transitionToMainFeedVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate,
          let window = sceneDelegate.window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromTop, animations: {
          if FirebaseAuthService.manager.currentUser != nil {
            window.rootViewController = TabBarViewController()
          } else {
            window.rootViewController = { () -> TabBarViewController in
              let searchVC = TabBarViewController()
              return searchVC
            }()
          }
        }, completion: nil)
    }
 //MARK: Firebase Methods
    private func handleSignUpResponse(withResult result: Result<User, Error>) {
        let alertTitle: String
        let alertMessage: String
        switch result {
        case let .success(user):
          transitionToMainFeedVC()
          print("Create user with email \(user.email ?? "no email") and \(user.uid)")
        case let .failure(error):
          alertTitle = "Sign Up Failure"
          alertMessage = "An error occured while Signing Up in: \(error.localizedDescription)"
          showErrorAlert(title: alertTitle, message: alertMessage)
        }
    }
    private func signUpUser(_ sender: UIButton) {
// To Do : add parameter for userName
        FirebaseAuthService.manager.createNewUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] (result) in
            self?.handleSignUpResponse(withResult: result)
        }
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

//MARK: Extension
extension SignupAuthViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
