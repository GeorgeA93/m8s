//
//  Image.swift
//  m8s
//
//  Created by George Allen on 20/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation
import Firebase

class Image {
    
    var key: String!
    var imageLocation: String!
    var uiimage: UIImage!
    
    init(imageLocation: String, key: String = ""){
        self.key = key
        self.imageLocation = imageLocation
    }
    
    func loadImage(completion: ((NSError!) -> Void)) {
        if(self.imageLocation == ""){
            return
        }
        let storageRef = FIRStorage.storage()
        let imageRef = storageRef.referenceForURL(self.imageLocation)
        imageRef.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) -> Void in
            if(error != nil){
                completion(error)
            } else {
                if let data = data {
                    self.uiimage = UIImage(data: data)
                    completion(nil)
                } else {
                    completion(NSError(domain: "Image", code: 0, userInfo: nil))
                }
            }
        })
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "imageLocation": imageLocation
        ]
    }
}