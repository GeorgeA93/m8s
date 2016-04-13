//
//  SwipeViewController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SwipeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if the user needs to login show login screen
        //if the user has no preferences show the preferences screen
        //else we set up the swiping screen
        if(true) {
         //   self.performSegueWithIdentifier("ShowLogin", sender: self)
        } 

        let loginButton = Services.userService.CreateFbLoginButton()
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton);

        
        if let user = Services.userService.currentUser {
            print(user.fullName)
        } else {

        }
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

extension SwipeViewController : SlideMenuControllerDelegate {

}