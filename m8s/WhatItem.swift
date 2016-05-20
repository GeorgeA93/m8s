//
//  WhatItem.swift
//  m8s
//
//  Created by George Allen on 19/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//


import Firebase

class WhatItem {
    
    var key: String!
    var name: String!
    var imageKey: String!
    
    init(name: String, imageKey: String, key: String = ""){
        self.key = key
        self.name = name
        self.imageKey = imageKey
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "imageKey": imageKey
        ]
    }
    
}