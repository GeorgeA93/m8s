//
//  WhenViewController.swift
//  m8s
//
//  Created by George Allen on 28/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class WhenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private weak var whenCollectionView: UICollectionView!
    @IBOutlet private weak var revealButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        whenCollectionView.dataSource = self
        whenCollectionView.delegate = self
        
        let layout = whenCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
        
        //uncoment for a nice image behind the collection view cells
        //whenCollectionView.backgroundView = UIImageView(image: UIImage(named:"city2"))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("WHEN")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        whenCollectionView.setContentOffset(CGPointZero, animated: true)
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
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
        if (indexPath.row == 0) {
            cell.label!.text = "TODAY";
            cell.imageView!.image = UIImage(named: "city7");
        } else if (indexPath.row == 1) {
            cell.label!.text = "TOMORROW";
            cell.imageView!.image = UIImage(named: "city2");

        } else if (indexPath.row == 2) {
            cell.label!.text = "FRIDAY";
            cell.imageView!.image = UIImage(named: "city3");

        } else if (indexPath.row == 3) {
            cell.label!.text = "SATURDAY";
            cell.imageView!.image = UIImage(named: "city4");

        } else if (indexPath.row == 4) {
            cell.label!.text = "SUNDAY";
            cell.imageView!.image = UIImage(named: "city5");

        } else if (indexPath.row == 5) {
            cell.label!.text = "MONDAY";
            cell.imageView!.image = UIImage(named: "city6");

        } else if (indexPath.row == 6) {
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "dayTapped") {
            //add day to preferences
            print("day")
        } else if(segue.identifier == "nightTapped") {
            //add night to preferences
            print("night")
        }
     }
}



