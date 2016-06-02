//
//  Plan.swift
//  m8s
//
//  Created by George Allen on 25/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Firebase

class Plan {
    
    var key: String!
    var date: String!
    var time: String!
    var activity: String!
    var place: String!
    var attendees: [String]!
    
    init(date: String, time: String, activity: String, place: String, attendees: [String], key: String = ""){
        self.key = key
        self.date = date
        self.time = time
        self.activity = activity
        self.place = place
        self.attendees = attendees
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "date": date,
            "time": time,
            "activity": activity,
            "place": place,
            "attendees": attendees
        ]
    }
    
}
