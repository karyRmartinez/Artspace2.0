//
//  AppUser.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/24/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

fileprivate let imageURLKey = "profileImageURL"

struct AppUser {
    let username: String?
    let userEmail: String?
    let uid: String
    let dateCreated: Date?
    let profileImageURL: String?
    
    init(from user: User) {
        self.username = user.displayName
        self.userEmail = user.email
        self.uid = user.uid
        self.profileImageURL = user.photoURL?.absoluteString
        self.dateCreated = user.metadata.creationDate
    }
    
    //    MARK: - Failable init
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["username"] as? String,
              let email = dict["userEmail"] as? String,
              let profileImageURL = dict["profileImageURL"] as? String,
              let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else {return nil}
        self.username = userName
        self.userEmail = email
        self.dateCreated = dateCreated
        self.uid = id
        self.profileImageURL = profileImageURL
    }
    
    var fieldsDict: [String:Any] {
        return ["username": self.username ?? "", "userEmail": self.userEmail ?? "", "uid": self.uid, "profileImageURL": self.profileImageURL ?? ""]
    }
}
