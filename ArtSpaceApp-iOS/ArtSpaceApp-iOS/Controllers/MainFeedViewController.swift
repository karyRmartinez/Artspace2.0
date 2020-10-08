//
//  MainFeedViewController.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/8/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewController()
    }
    
    func configureViewController() {
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonPressed))
        navigationItem.rightBarButtonItem = signOutButton

        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func signOutButtonPressed() {
        do {
          try FirebaseAuthService.manager.signOutUser()
        } catch let error {
          print("\(error.localizedDescription)")
        }
    }
}
