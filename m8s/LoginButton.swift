//
//  LoginButton.swift
//  m8s
//
//  Created by George Allen on 31/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class LoginButton : NSObject, FBSDKLoginButtonDelegate {
    
    private var fbLoginButton: FBSDKLoginButton
    
    init(fbLoginButton: FBSDKLoginButton) {
        self.fbLoginButton = fbLoginButton;
        super.init()
        
        self.fbLoginButton.delegate = self;
    }
    
    @objc func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        Services.userService.HandleLogin(result, error: error)
    }
    
    @objc func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        Services.userService.HandleLogout()
    }
    
    @objc func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true;
    }
}

