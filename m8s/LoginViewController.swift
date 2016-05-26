//
//  LoginViewController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    let loginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile", "user_friends"]
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = UserService.currentUser() {
            self.completeLogin()
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            //show something to user
            return
        }
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        firebaseLogin(credential)
    }
    
    func firebaseLogin(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                //show something to user
            }
            self.completeLogin()
        })
    }
    
    private func completeLogin() {
        let slideMenuController = SlideMenuService.createSlideMenu()
        self.presentViewController(slideMenuController, animated: false, completion: nil)
    }

}
