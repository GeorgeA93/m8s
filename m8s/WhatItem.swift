//
//  WhatItem.swift
//  m8s
//
//  Created by George Allen on 19/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//


import Firebase
import FirebaseStorage

class WhatItem {
    
    var key: String!
    var name: String!
    var image: UIImage!
    private var imageLocation: String!
    
    init(name: String, imageLocation: String, key: String = ""){
        self.key = key
        self.name = name
        self.imageLocation = imageLocation
    }
    
    func loadImage(completion: (() -> Void)!) {
        if let _ = self.image {
            completion()
            return
        }
        
        if(self.imageLocation == ""){
            return
        }
        
        let storageRef = FIRStorage.storage()
        let imageRef = storageRef.referenceForURL(self.imageLocation)
        
        imageRef.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) -> Void in
            if(error != nil){
                print(error?.localizedDescription)
            } else {
                self.image = UIImage(data: data!)
                completion()
            }
        })
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name
        ]
    }
    
}