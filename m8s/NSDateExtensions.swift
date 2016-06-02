//
//  NSDateExtensions.swift
//  m8s
//
//  Created by George Allen on 02/06/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

extension NSDate {
    
    func toShortDateString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        return dateFormatter.stringFromDate(self)
    }
    
    func add(amount: Int, unit: NSCalendarUnit = NSCalendarUnit.Day) -> NSDate! {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        return calendar.dateByAddingUnit(unit, value: amount, toDate: self, options: [])
    }
    
    func getComponents(unitFlags: NSCalendarUnit) -> NSDateComponents {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        return calendar.components(unitFlags, fromDate: self)
    }
    
}