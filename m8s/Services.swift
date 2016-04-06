//
//  Services.swift
//  m8s
//
//  Created by George Allen on 01/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation


class Services {
    
    
    private static var _userService: UserService?
    static var userService: UserService {
        get {
            if(_userService == nil) {
                _userService = UserService()
            }
            return _userService!
        }
    }
    
}