//
//  FirenbaseAuthService.swift
//  ArtSpaceApp-iOS
//
//  Created by Kary Martinez on 10/6/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//


import Foundation
import FirebaseAuth

fileprivate enum GenericError: Error {
  case unknown
}

class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()
    
    internal var currentUser: User? {
        return auth.currentUser
    }
    
    internal func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    internal func updateUserFields(userName: String? = nil,photoURL: URL? = nil, completion: @escaping (Result<(),Error>) -> ()){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changeRequest?.displayName = userName
        }
        if let photoURL = photoURL {
            changeRequest?.photoURL = photoURL
        }
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    
    internal func loginUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                onCompletion(.success(user))
            } else {
                onCompletion(.failure(error ?? GenericError.unknown))
            }
        }
    }
    
    internal func signOutUser() {
        do{
            try auth.signOut()
        } catch let error {
            print(error)
        }
    }
    
    private init () {}
}
