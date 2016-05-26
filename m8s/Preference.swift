//
//  Preference.swift
//  m8s
//
//  Created by George Allen on 25/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Firebase
import FirebaseDatabase

class Preference {
    
    //The user Id
    var uid: String!
    var whatItemId: String!
    var whatItem: WhatItem?
    var whenItemId: String!
    var whenItem: WhenItem?
    
    init(uid: String, whatItemId: String, whenItemId: String){
        self.uid = uid
        self.whatItemId = whatItemId
        self.whenItemId = whenItemId
        loadWhatItem()
        loadWhenItem()
    }
    
    private func loadWhatItem() {
        FIRDatabase.database().reference().child("what-items").child(whatItemId).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if(snapshot.exists()){
                if let value = snapshot.value {
                    let name = value["name"] as! String
                    let imageKey = value["imageKey"] as! String
                    self.whatItem = WhatItem(name: name, imageKey: imageKey, key: snapshot.key)
                } else {
                    print("Failed to load what item on preference")
                }
            }  else {
                print("Failed to load what item on preference")
            }
        })
    }
    
    private func loadWhenItem() {
        FIRDatabase.database().reference().child("when-items").child(whenItemId).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if(snapshot.exists()){
                if let value = snapshot.value {
                    let name = value["name"] as! String
                    let imageKey = value["imageKey"] as! String
                    self.whenItem = WhenItem(name: name, imageKey: imageKey, key: snapshot.key)
                } else {
                    print("Failed to load when item on preference")
                }
            } else {
                print("Failed to load when item on preference")
            }
        })
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "uid": uid,
            "whatItemId": whatItemId,
            "whenItemId": whenItemId
        ]
    }
    
    func save() {
        
    }
    
}