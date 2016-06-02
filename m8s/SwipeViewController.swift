//
//  SwipeViewController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Koloda
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var swipingView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipingView.dataSource = self
        swipingView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //This code should be in viewWillAppear but an issue with SlideMenuControllerSwift needs to be fixed first
    //The relevant issues where #129 and #95
    //Potentially fixed when PR #50 is merged
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem("M8S")
        UserService.getCurrentPreference({preferences in
            if(preferences == nil){
               // self.performSegueWithIdentifier("noPreferences", sender: self)
            }
        })
        
        /*
        if let user = UserService.currentUser() {
         
            for index in 0...4 {
                let plan = Plan(date: "6/15/16", time: "day", activity: "anything", place: "anywhere", attendees: ["a", "b", "c"])
                let planId = FIRDatabase.database().reference().child("plans").childByAutoId().key
                planIds.append(planId)
                FIRDatabase.database().reference().child("plans").child(planId).setValue(plan.toAnyObject())
            }
            let userPlan = UserPlan(planIds: planIds)
            FIRDatabase.database().reference().child("user-plans").child(user.uid).setValue(userPlan.toAnyObject())
        }
 */
        if let user = UserService.currentUser() {
            var planIds = [String]()
            let plan = Plan(date: NSDate().toShortDateString(), time: "day", activity: "anything", place: "anywhere", attendees: ["a", "b", "c"])
            let planId = FIRDatabase.database().reference().child("plans").childByAutoId().key
            planIds.append(planId)
            FIRDatabase.database().reference().child("plans").child(planId).setValue(plan.toAnyObject())
            let userPlan = UserPlan(planIds: planIds)
            FIRDatabase.database().reference().child("user-plans").child(user.uid).setValue(userPlan.toAnyObject())
        }
        
        UserService.getPlanForToday({ plan in
        })
 
       
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: KolodaViewDelegate
extension SwipeViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
        if index >= 3 {
           // numberOfCards = 6
            swipingView.reloadData()
        }
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        //dataSource.insert(UIImage(named: "Card_like_6")!, atIndex: kolodaView.currentCardIndex - 1)
        //let position = swipingView.currentCardIndex
        //swipingView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
       // UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

//MARK: KolodaViewDataSource
extension SwipeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return 10;
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return (NSBundle.mainBundle().loadNibNamed("SwipeCardView",
            owner: self, options: nil)[0] as? SwipeCardView)!
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("SwipingOverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}


extension SwipeViewController : SlideMenuControllerDelegate {

}
 