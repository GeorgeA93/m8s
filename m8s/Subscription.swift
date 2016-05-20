//
//  Subscription.swift
//  m8s
//
//  Created by George Allen on 20/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class Subscription {
    
    let id: String
    let key: StorageService.Key
    let callback: () -> Void
    
    init(key: StorageService.Key, callback: () -> Void){
        self.key = key
        self.callback = callback
        self.id = NSUUID().UUIDString
    }
}