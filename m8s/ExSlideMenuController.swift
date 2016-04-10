//
//  ExSlideMenuController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is SwipeViewController ||
                vc is AboutViewController ||
                vc is SettingsViewController ||
                vc is WhenViewController ||
                vc is WhatViewController ||
                vc is WhereViewController {
                return true
            }
        }
        return false
    }
}
