//
//  MenuHeaderView.swift
//  m8s
//
//  Created by George Allen on 12/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class MenuHeaderView: UIView {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        
        if UserService.shared.isLoggedIn() {
            self.nameLabel!.text = UserService.shared.currentUser()?.displayName
            self.profilePictureView.image = UIImage(data: NSData(contentsOfURL: (UserService.shared.currentUser()?.photoURL)!)!)
            self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.width / 2
            self.profilePictureView.clipsToBounds = true
        }
    }
}
