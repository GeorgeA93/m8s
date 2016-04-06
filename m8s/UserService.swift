//
//  UserService.swift
//  m8s
//
//  Created by George Allen on 01/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import Foundation

class UserService : NSObject {
    
    private(set) var currentUser: User?
    private var loginButtonController: LoginButton?
    private var profileChangedSubscribers: Dictionary<String, Void->Void>
    override init () {
        profileChangedSubscribers = Dictionary<String, Void->Void>()
        super.init()
        
        subscribeToProfileChange("userServiceProfileChanged", callback: profileChanged)
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onProfileUpdated(_:)), name:FBSDKProfileDidChangeNotification, object: nil)
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            currentUser = User(accessToken: accessToken)
            if let profile = FBSDKProfile.currentProfile() {
                setUpUser(profile)
            }
        }
    }
    
    func subscribeToProfileChange(key: String, callback: Void -> Void) {
        profileChangedSubscribers.updateValue(callback, forKey: key)
    }
    
    func unsubscribeToProfileChange(key: String) {
        profileChangedSubscribers.removeValueForKey(key)
    }
    
    func onProfileUpdated(notification: NSNotification)
    {
        if(!profileChangedSubscribers.isEmpty){
            for (_, val) in profileChangedSubscribers {
                val()
            }
        }
    }
    
    private func profileChanged() {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            if let profile = FBSDKProfile.currentProfile(){
                setUpUser(profile)
            }
        } else {
            HandleLogout()
        }
    }
    
    func HandleLogin(result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if let e = error {
            print(e)
        } else {
            if let r = result {
                if(r.isCancelled) {
                    HandleCancel();
                } else {
                    if let accessToken = FBSDKAccessToken.currentAccessToken() {
                        currentUser = User(accessToken: accessToken)
                    }
                }
            }
        }
    }
    
    private func setUpUser(profile: FBSDKProfile) {
        //check whether user is new or old
        //get user data from rest api or setup new user
        //populate user with said data. or default data
        print("we are setting up the users profile")
        print(profile)
        if let user = currentUser {
            user.firstName = profile.firstName
            user.lastName = profile.lastName
        }
    }
    
    private func HandleCancel() {
        if(currentUser != nil) {
            currentUser = nil
        }
    }
    
    func HandleLogout() {
       currentUser = nil
    }
    
    func DeleteAccount() {
        //delete user account
        //delete all data associated with user
        //could call a procedure on the server
    }
    
    func CreateFbLoginButton() -> FBSDKLoginButton {
        let loginButton = FBSDKLoginButton()
        loginButtonController = LoginButton(fbLoginButton: loginButton)
        return loginButton
    }
}