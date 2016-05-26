//
//  UserService.swift
//  m8s
//
//  Created by George Allen on 25/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserService {

    private static var databaseRef: FIRDatabaseReference!
    
    static func create() {
        databaseRef = FIRDatabase.database().reference()
    }
    
    static func destroy() {
        databaseRef = nil
    }
    
    private static func isValidPreference(preference: AnyObject) -> Bool {
        return (preference.hasChild("uid") &&
            preference.hasChild("whatItemId") &&
            preference.hasChild("whenItemId"))
    }
    
    static func getPreferences(completion: (Preference!) -> Void) {
        if let user = currentUser() {
            getPreferences(user, completion: completion)
        } else {
            completion(nil)
        }
    }
    
    static func getPreferences(user: FIRUser, completion: (Preference!) -> Void) {
        databaseRef.child("preferences").child(user.uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if(snapshot.exists()) {
                if let value = snapshot.value {
                    if(isValidPreference(value)){
                        let uid = value["uid"] as! String
                        let whatItemId = value["whatItemId"] as! String
                        let whenItemId = value["whenItemId"] as! String
                        let pref = Preference(uid: uid, whatItemId: whatItemId, whenItemId: whenItemId)
                        completion(pref)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        })
    }
    
    static func isLoggedIn() -> Bool {
        if let _ = currentUser() {
            return true
        }
        return false
    }
    
    static func currentUser() -> FIRUser? {
        if let user = FIRAuth.auth()?.currentUser {
            return user
        }
        return nil
    }
}
