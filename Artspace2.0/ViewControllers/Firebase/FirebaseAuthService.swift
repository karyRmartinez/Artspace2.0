//
//  FirebaseAuthService.swift
//  Artspace2.0
//
//  Created by Kary Martinez on 9/22/20.
//  Copyright © 2020 Artspace. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    func createNewUser(email:String, password: String, completion: @escaping(Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in if let createdUser = result?.user {
            completion(.success(createdUser))
        } else if let error = error {
            completion(.failure(error))
            }
            
        }
    }
    
    func updatedUserFields(userName: String? = nil, PhotoURL:URL? = nil, completion: @escaping (Result<(),Error>) -> ()) {
        let changedRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changedRequest?.displayName = userName
        }
        if let photoURL = PhotoURL {
            changedRequest?.photoURL = photoURL
        }
        changedRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(<#T##()#>))
            }
            
        })
    }
    
    func loginUser(email: String, password: String, completion: @escaping(Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    private init () {}
}
