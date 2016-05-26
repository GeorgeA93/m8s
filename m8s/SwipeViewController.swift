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
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem("M8S")
        UserService.getPreferences({preferences in
            if(preferences == nil){
                self.performSegueWithIdentifier("noPreferences", sender: self)
            }
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
 