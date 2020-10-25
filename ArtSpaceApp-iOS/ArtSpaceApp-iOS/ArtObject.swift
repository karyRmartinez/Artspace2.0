//
//  ArtObject.swift
//  ArtSpaceApp-iOS
//
//  Created by Jocelyn Boyd on 10/24/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct ArtObject {
    let username: String
    let imageDescription: String
    let imageURL: String
    let imageID: String
    let dateCreated: Date?
    let imageTags: [String]
    
    init(username: String, imageDescription: String, imageURL: String, dateCreated: Date? = nil, imageTags: [String]){
        self.username = username
        self.imageDescription = imageDescription
        self.imageURL = imageURL
        self.imageID = UUID().uuidString
        self.dateCreated = dateCreated
        self.imageTags = imageTags
    }
    
    init?(from dict: [String:Any], id: String) {
        guard let username = dict["username"] as? String,
              let imageDescription = dict["imageDescription"] as? String,
              let imageURL = dict["imageURL"] as? String,
              let imageID = dict["imageID"] as? String,
              let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
              let imageTags = dict["imageTags"] as? [String] else {return nil}
        
        self.username = username
        self.imageDescription = imageDescription
        self.imageURL = imageURL
        self.dateCreated = dateCreated
        self.imageID = imageID
        self.imageTags = imageTags
    }
    
    var fieldsDict: [String:Any] {
        return ["username": self.username, "imageDescription": self.imageDescription, "imageURL": self.imageURL, "imageID": self.imageID, "imageTags": self.imageTags ]
    }
}
