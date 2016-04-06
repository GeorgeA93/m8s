//
//  User.swift
//  m8s
//
//  Created by George Allen on 31/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class User {
    
    private var accessToken: FBSDKAccessToken
    private var profile: FBSDKProfile?
    
    var userId: String {
        get {
            return accessToken.userID
        }
    }
    
    var profilePicture: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    
    var fullName: String? {
        get {
            if let first = firstName {
                if let last = lastName {
                    return first + " " + last
                }
            }
            return nil
        }
    }
    
    init(accessToken: FBSDKAccessToken) {
        self.accessToken = accessToken
    }
    
    deinit {
        
    }
}