//
//  UIViewControllerExtensions.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

extension UIViewController {
    
    func setNavigationBarItem(title: String?) {
        self.addLeftBarButtonWithImage(UIImage(named: "hamburgerMenu")!)
        self.addRightBarButtonWithImage(UIImage(named: "hamburgerMenu")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        if let t = title {
            self.title = t
        }
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
