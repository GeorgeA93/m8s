//
//  WhenCollectionViewCell.swift
//  m8s
//
//  Created by George Allen on 29/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCover: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet private weak var dayButton: UIButton!
    @IBOutlet private weak var nightButton: UIButton!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let featuredHeight = WhenCollectionLayoutConstants.Cell.featuredHeight
        let standardHeight = WhenCollectionLayoutConstants.Cell.standardHeight
        
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight)) //delta is one when the cell is featured.
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        imageCover.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        dayLabel.transform = CGAffineTransformMakeScale(scale, scale)
        dayLabel.alpha = max(delta, 0.3);
        
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
        print("day")

    }

    @IBAction func nightTap(sender: AnyObject) {
       print("night")
    }
}
