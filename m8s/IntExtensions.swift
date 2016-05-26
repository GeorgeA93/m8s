//
//  IntExtensions.swift
//  m8s
//
//  Created by George Allen on 26/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation


extension Int {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
    
    func toWeekday() -> String {
        switch(self){
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
}