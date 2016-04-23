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

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var swipingView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if the user needs to login show login screen
        //if the user has no preferences show the preferences screen
        //else we set up the swiping screen
        if(true) {
         //   self.performSegueWithIdentifier("ShowLogin", sender: self)
        } 

        //let loginButton = Services.userService.CreateFbLoginButton()
       // loginButton.center = self.view.center;
        //self.view.addSubview(loginButton);

        swipingView.dataSource = self
        swipingView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("M8S")
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
}

//MARK: KolodaViewDataSource
extension SwipeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return 10;
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        //return UIImageView(image: dataSource[Int(index)])
        return UIView();
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
                                                  owner: self, options: nil)[0] as? OverlayView
    }
}

extension SwipeViewController : SlideMenuControllerDelegate {

}