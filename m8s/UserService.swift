//
//  UserService.swift
//  m8s
//
//  Created by George Allen on 25/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

private let _shared = UserService()

class UserService {
    class var shared: UserService {
        return _shared
    }
    
    private let concurrentPlanQueue = dispatch_queue_create(
    "com.allen.george.m8s.planQueue", DISPATCH_QUEUE_CONCURRENT)
    
    private var databaseRef: FIRDatabaseReference!
    
    init() {
        self.databaseRef = FIRDatabase.database().reference()
    }

    func destroy() {
        databaseRef = nil
    }

    func getPlanForToday(completion: (Plan!) -> Void) {
        if let user = currentUser() {
            getPlanForToday(user, completion: completion)
        } else {
            completion(nil)
        }
    }

    func getPlanForToday(user: FIRUser, completion: (Plan!) -> Void) {
        getUserPlans(user, completion: {
            plans in
            if let plans = plans {
                let plansToday = plans.filter({$0.date == NSDate().toShortDateString()})
                if plansToday.any() {
                    completion(plansToday.first)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }

    func getUserPlans(completion: ([Plan]!) -> Void) {
        if let user = currentUser() {
            getUserPlans(user, completion: completion)
        } else {
            completion(nil)
        }
    }

    func getUserPlans(user: FIRUser, completion: ([Plan]!) -> Void) {
        getUserPlan(user, completion: {
            userPlan in
            if let userPlan = userPlan {
                self.getPlans(userPlan, completion: {
                    plans in
                    completion(plans)
                })
            } else {
                completion(nil)
            }
        })
    }

    func getUserPlan(completion: (UserPlan!) -> Void) {
        if let user = currentUser() {
            getUserPlan(user, completion: completion)
        } else {
            completion(nil)
        }
    }

    func getUserPlan(user: FIRUser, completion: (UserPlan!) -> Void) {
        databaseRef.child("user-plans").child(user.uid).observeSingleEventOfType(.Value, withBlock: {
            snapshot in
            if snapshot.exists() {
                if let value = snapshot.value {
                    let planIds = value["planIds"] as! [String]
                    let userPlan = UserPlan(planIds: planIds, key: snapshot.key)
                    completion(userPlan)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }

    private func getPlans(userPlan: UserPlan, completion: ([Plan]!) -> Void) {
        let getPlanGroup = dispatch_group_create()
        var plans = [Plan]()
        for planId in userPlan.planIds {
            dispatch_group_enter(getPlanGroup)
            getPlan(planId, completion: {
                plan in
                if let plan = plan {
                    dispatch_barrier_async(self.concurrentPlanQueue) {
                        plans.append(plan)
                    }
                }
                dispatch_group_leave(getPlanGroup)
            })
        }
        dispatch_group_notify(getPlanGroup, dispatch_get_main_queue()) {
            if !plans.any() {
                completion(nil)
            } else {
                completion(plans)
            }
        }
    }

    private func getPlan(planId: String, completion: (Plan!) -> Void) {
        databaseRef.child("plans").child(planId).observeSingleEventOfType(.Value, withBlock: {
            snapshot in
            if snapshot.exists() {
                if let value = snapshot.value {
                    let date = value["date"] as! String
                    let time = value["time"] as! String
                    let activity = value["activity"] as! String
                    let place = value["place"] as! String
                    let attendees = value["attendees"] as! [String]
                    let plan = Plan(date: date, time: time, activity: activity, place: place,
                            attendees: attendees, key: snapshot.key)
                    completion(plan)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
    }

    func isLoggedIn() -> Bool {
        if let _ = currentUser() {
            return true
        }
        return false
    }

    func currentUser() -> FIRUser? {
        if let user = FIRAuth.auth()?.currentUser {
            return user
        }
        return nil
    }
}
