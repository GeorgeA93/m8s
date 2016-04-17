//
//  ImageCollectionViewCell.swift
//  m8s
//
//  Created by George Allen on 06/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCover: UIView!
    
    var delta: CGFloat {
        get {
            return 1 - ((ImageCollectionLayoutConstants.Cell.featuredHeight - CGRectGetHeight(frame)) / (ImageCollectionLayoutConstants.Cell.featuredHeight - ImageCollectionLayoutConstants.Cell.standardHeight)) //delta is one when the cell is featured.
        }
    }
 
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        imageCover.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        label.transform = CGAffineTransformMakeScale(scale, scale)
        label.alpha = max(delta, 0.3);
    }
    
}
