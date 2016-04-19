//
//  WhatCollectionViewCell.swift
//  m8s
//
//  Created by George Allen on 14/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhatCollectionViewCell: ImageCollectionViewCell {
    
    var whatViewController: WhatViewController!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        backButton.alpha = delta
        forwardButton.alpha = delta
    }
    
    @IBAction func forwardButtonTap(sender: AnyObject) {
        print("forward")
    }
    
    @IBAction func backButtonTap(sender: AnyObject) {
        print("back")
    }

}

