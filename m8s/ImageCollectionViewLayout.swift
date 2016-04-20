//
//  WhenCollectionViewLayout.swift
//  m8s
//
//  Created by George Allen on 29/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit


struct ImageCollectionLayoutConstants {
    struct Cell {
        static let standardHeight: CGFloat = 100;
        static let featuredHeight: CGFloat = 400;
    }
}

class ImageCollectionViewLayout: UICollectionViewLayout {

    //The amount the user needs to scroll before the featured cell changes
    let dragOffset: CGFloat = 180;
    
    var cache = [UICollectionViewLayoutAttributes]();
    
    //Returns the item index of the currently featured cell
    var featuredItemIndex: Int {
        get {
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    //Returns the value between 0 and 1 that represents how close the next cell is to become the featured cell
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex);
        }
    }
    
    //Returns the width of the collection view
    var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    //Returns the height of the collection view 
    var height: CGFloat {
        get {
            return CGRectGetHeight(collectionView!.bounds)
        }
    }
    
    //Returns the number of items in the collection view
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItemsInSection(0);
        }
    }
    
    //Return the size of all the content in the collection view
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        cache.removeAll(keepCapacity: false)
        
        if(collectionView!.contentOffset.y < 0){
            collectionView!.contentOffset.y = 0
        }
        
        let standardHeight = ImageCollectionLayoutConstants.Cell.standardHeight
        let featuredHeight = ImageCollectionLayoutConstants.Cell.featuredHeight
        
        var frame = CGRectZero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            //Important because each cell has to slide over the top of the previous one
            attributes.zIndex = item
            //Initially set the height of the cell to the standard height
            var height = standardHeight
            if indexPath.item == featuredItemIndex {
                //The featured cell
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                //The cell directly below the featured cell, which grows as the user scrolls
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }

            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = CGRectGetMaxY(frame)
        }
        print(featuredItemIndex)
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    //Return the content offset of the nearest cell which achieves the nice snapping effect, similar to a paged UIScrollView
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }
    
    //Return true so that the layout is continuously invalidated as the user scrolls
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    
    
}
