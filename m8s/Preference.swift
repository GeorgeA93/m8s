//
//  Preference.swift
//  m8s
//
//  Created by George Allen on 04/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class Preference : Entity{
    
    var whenId: Int
    var whatId: Int
    var whereId: Int
    
    override init() {
        self.whenId = 0
        self.whatId = 0
        self.whereId = 0
        super.init()
    }
    
}