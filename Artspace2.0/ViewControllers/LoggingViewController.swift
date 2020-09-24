//
//  LoggingViewController.swift
//  Artspace2.0
//
//  Created by Kary Martinez on 9/17/20.
//  Copyright © 2020 Artspace. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "ArtSpace: Create Account"
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .bezel
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .bezel
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    
 lazy var LoginButton: UIButton = {
       let button = UIButton()
       button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
      button.isEnabled = false
       return button
       
   }()
    private func addSubviews() {
         self.view.addSubview(headerLabel)
         self.view.addSubview(LoginButton)
         self.view.addSubview(passwordTextField)
         self.view.addSubview(LoginButton)

     }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setTextFieldConstraints()
        setLoginLabelConstraints()
       
    }
    //MARK: Obj-C Methods
       
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
             LoginButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 0.5)
             LoginButton.isEnabled = false
             return
         }
         LoginButton.isEnabled = true
         LoginButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 1)
    }
    @objc func tryLogin() {
           guard let email = emailTextField.text, let password = passwordTextField.text else {
               showAlert(with: "Error", and: "Please fill out all fields.")
               return
           }
           
           //MARK: TODO - remove whitespace (if any) from email/password
           
           guard email.isValidEmail else {
               showAlert(with: "Error", and: "Please enter a valid email")
               return
           }
           
           guard password.isValidPassword else {
               showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
               return
           }
           
           FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
               self.handleLoginResponse(with: result)
           }
       }
    private func showAlert(with title: String, and message: String) {
           let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alertVC, animated: true, completion: nil)
       }
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            showAlert(with: "Error", and: "Could not log in. Error: \(error)")
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    //MARK: TODO - handle could not swap root view controller
                    return
            }
            
            //MARK: TODO - refactor this logic into scene delegate
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                    window.rootViewController = TabBarViewController()
                } else {
                    window.rootViewController = {
                        let profileSetupVC = ProfileViewController()
                        profileSetupVC.settingFromLogin = true
                        return profileSetupVC
                    }()
                }
            }, completion: nil)
        }
    }
    

    //MARK:   CONSTRAINTS
        private func setTextFieldConstraints() {
             NSLayoutConstraint.activate([
                emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
                emailTextField.widthAnchor.constraint(equalToConstant: 200),
                 emailTextField.heightAnchor.constraint(equalToConstant: 35)
             ])
         }

      private func setPSTextFieldConstraints() {
              NSLayoutConstraint.activate([
                passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
                 passwordTextField.widthAnchor.constraint(equalToConstant: 200),
                  passwordTextField.heightAnchor.constraint(equalToConstant: 35)
              ])
          }

      
      private func setLoginLabelConstraints() {
              NSLayoutConstraint.activate([
                LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               LoginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
               LoginButton.widthAnchor.constraint(equalToConstant: 130),
                LoginButton.heightAnchor.constraint(equalToConstant: 35)
              ])
          
}

}
