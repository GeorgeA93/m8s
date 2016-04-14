//
//  WhatViewController.swift
//  m8s
//
//  Created by George Allen on 06/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var whatCollectionView: UICollectionView!
    var whereViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let whereViewController = storyboard.instantiateViewControllerWithIdentifier("WhereViewController") as! WhereViewController
        self.whereViewController = UINavigationController(rootViewController: whereViewController)
        
        whatCollectionView.dataSource = self
        whatCollectionView.delegate = self

        let layout = whatCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("WHAT")
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Will need to take an option here. (Anything/Drinks etc)
    func complete() {
        self.slideMenuController()?.changeMainViewController(self.whereViewController, close: false)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhatCell", forIndexPath: indexPath) as! WhatCollectionViewCell
        cell.whatViewController = self
        if(indexPath.row == 0){
            cell.label!.text = "ANYTHING";
            cell.imageView!.image = UIImage(named: "city7");
        } else if(indexPath.row == 1){
            cell.label!.text = "DRINKS";
            cell.imageView!.image = UIImage(named: "city2");
            
        } else if(indexPath.row == 2){
            cell.label!.text = "CLUBBING";
            cell.imageView!.image = UIImage(named: "city3");
            
        } else if(indexPath.row == 3){
            cell.label!.text = "CINEMA";
            cell.imageView!.image = UIImage(named: "city5");
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = whatCollectionView.collectionViewLayout as! ImageCollectionViewLayout
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
