//
//  User.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: Int64?
    var username: String?
    var displayName: String?
    var favoritesCount: Int?
    var profilePicture: URL?
    
    init(dictionary: NSDictionary) {
        id = dictionary[userKeys.id] as? Int64
        username = dictionary[userKeys.username] as? String
        displayName = dictionary[userKeys.name] as? String
        favoritesCount = dictionary[userKeys.favoritesCount] as? Int
        if let pictureString = dictionary[userKeys.profilePicture] as? String {
            profilePicture = URL(string: pictureString)
        }
    }
}
