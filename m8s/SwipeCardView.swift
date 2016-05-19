//
//  SwipeCardView.swift
//  m8s
//
//  Created by George Allen on 26/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import FMMosaicLayout

class SwipeCardView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, FMMosaicLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout : FMMosaicLayout = FMMosaicLayout()
        collectionView?.collectionViewLayout = layout
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView.registerNib(UINib(nibName: "SwipeCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCardCollectionViewCell")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SwipeCardCollectionViewCell", forIndexPath: indexPath) as! SwipeCardCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAtIndexPath indexPath: NSIndexPath!) -> FMMosaicCellSize {
        return FMMosaicCellSize.Big
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0;
    }
}
