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
        self.nameLabel!.text = "George Allen"
        
        if let profile = FBSDKProfile.currentProfile() {
            let s = profile.imageURLForPictureMode(FBSDKProfilePictureMode.Square, size: CGSize(width: self.profilePictureView.frame.width, height: self.profilePictureView.frame.height))
            let data = NSData(contentsOfURL: s)
            self.profilePictureView.image = UIImage(data: data!)
            self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.width / 2
            self.profilePictureView.clipsToBounds = true
        }
    }
}
