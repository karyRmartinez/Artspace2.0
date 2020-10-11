//
//  FirebaseAuthService.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/11/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation
import FirebaseAuth

enum GenericError: Error {
  case unknown
}

class FirebaseAuthService {
  
  // MARK: Static Properties
   static let manager = FirebaseAuthService()
  
  // MARK: Private Properties
  private let firebaseAuth = Auth.auth()
  
  // MARK: Internal Properties
  var currentUser: User? {
    return firebaseAuth.currentUser
  }
  
  // MARK: Internal Functions
  func createNewUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    firebaseAuth.createUser(withEmail: email, password: password) { (result, error) in
      if let createdUser = result?.user {
        onCompletion(.success(createdUser))
      } else {
        onCompletion(.failure(error ?? GenericError.unknown))
      }
    }
  }
  
  func loginUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in
      if let user = result?.user {
        onCompletion(.success(user))
      } else {
        onCompletion(.failure(error ?? GenericError.unknown))
      }
    }
  }
  
  func signOutUser() throws {
    try firebaseAuth.signOut()
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
      let sceneDelegate = windowScene.delegate as? SceneDelegate,
      let window = sceneDelegate.window else { return }
    
    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
      let homeAuthVC = LoginAuthViewController()
      window.rootViewController = homeAuthVC
    }, completion: nil)
  }
  
  // MARK: Private initializers
  private init() {}
}
