//
//  WhenCollectionViewCell.swift
//  m8s
//
//  Created by George Allen on 29/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhenCollectionViewCell: ImageCollectionViewCell {
    
    @IBOutlet private weak var dayButton: UIButton!
    @IBOutlet private weak var nightButton: UIButton!
    var whenViewController: WhenViewController!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        if(delta == 1){
            dayButton.alpha = 1;
            nightButton.alpha = 1;
            dayButton.enabled = true;
            nightButton.enabled = true;
        } else {
            dayButton.alpha = 0;
            nightButton.alpha = 0;
            dayButton.enabled = false;
            nightButton.enabled = false;
        }
    }
    
    @IBAction func dayTap(sender: AnyObject) {
        whenViewController.complete()
    }

    @IBAction func nightTap(sender: AnyObject) {
       print("night")
    }
}
