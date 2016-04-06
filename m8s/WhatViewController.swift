//
//  WhatViewController.swift
//  m8s
//
//  Created by George Allen on 06/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhenCell", forIndexPath: indexPath) as! WhenCollectionViewCell
        
        if(indexPath.row == 0){
            cell.label!.text = "TODAY";
            cell.imageView!.image = UIImage(named: "city7");
        } else if(indexPath.row == 1){
            cell.label!.text = "TOMORROW";
            cell.imageView!.image = UIImage(named: "city2");
            
        } else if(indexPath.row == 2){
            cell.label!.text = "FRIDAY";
            cell.imageView!.image = UIImage(named: "city3");
            
        }else if(indexPath.row == 3){
            cell.label!.text = "SATURDAY";
            cell.imageView!.image = UIImage(named: "city4");
            
        }else if(indexPath.row == 4){
            cell.label!.text = "SUNDAY";
            cell.imageView!.image = UIImage(named: "city5");
            
        }else if(indexPath.row == 5){
            cell.label!.text = "MONDAY";
            cell.imageView!.image = UIImage(named: "city6");
            
        }else if(indexPath.row == 6){
            cell.label!.text = "TUESDAY";
            cell.imageView!.image = UIImage(named: "city3");
            
        } else {
            cell.label!.text = "TODAY";
            cell.imageView!.image = UIImage(named: "city");
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = whenCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
