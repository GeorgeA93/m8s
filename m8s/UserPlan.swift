//
//  UserPlan.swift
//  m8s
//
//  Created by George Allen on 01/06/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class UserPlan {
    
    var key: String!
    var planIds: [String]!
    
    init(planIds: [String], key: String = "") {
        self.planIds = planIds
        self.key = key
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "planIds": planIds
        ]
    }
}