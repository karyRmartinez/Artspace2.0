//
//  SignInViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class logInViewController: UIViewController {
    
    let userFieldImage = UIImageView()
        
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.text = "ArtSpace"
        label.font = UIFont(name: "SavoyeLetPlain", size: 45.0)
        return label
    }()
    
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightText
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setSubviews()
        setConstraints()
        
    }
    
    //MARK: Obj-C Methods
    
 
    
    @objc func tryLogin() {
        
        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            showErrorAlert(title: "Error", message: "Please fill out all fields.")
            return
        }
        
        
        guard email.isValidEmail else {
            showErrorAlert(title: "Error", message: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            showErrorAlert(title: "Error", message: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        FirebaseAuthService.manager.loginUser(email: email, password: password) { [weak self] (result) in
            self?.handleLoginResponse(result: result)
        }
        
    }
    
    //MARK: Private func
    
    private func showErrorAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func handleLoginResponse(result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            showErrorAlert(title: "Error", message: "Could not log in. Error \(error)")
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
            
            UIView.transition(with: window, duration: 0.3, options: .curveLinear, animations: {
                window.rootViewController = HomeTabBarViewController()
            }, completion: nil)
        }
    }


    //MARK: UI Setup
    
    private func setSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginButton)
       
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
        setEmailFieldConstraints()
        setPasswordFieldConstraints()
        setLogInButtonConstraints()
       
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setEmailFieldConstraints() {
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 300),
            emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setPasswordFieldConstraints() {
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 300),
            passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setLogInButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    

 
}
