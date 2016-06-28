//
//  SlideMenuService.swift
//  m8s
//
//  Created by George Allen on 26/05/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import SlideMenuControllerSwift

class SlideMenuService {
    
    static func createSlideMenu() -> ExSlideMenuController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("SwipeViewController") as! SwipeViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("PlanMenuViewController") as! PlanMenuViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "FFFEF2")
        UINavigationBar.appearance().backgroundColor = UIColor(hex: "141414")
        UINavigationBar.appearance().barTintColor = UIColor(hex: "141414")
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hex: "FFFEF2")]
        
        leftViewController.mainViewController = nvc
        
        SlideMenuOptions.leftBezelWidth = 60
        SlideMenuOptions.contentViewScale = 1
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        
        return slideMenuController
    }
    
}
