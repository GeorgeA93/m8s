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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whatCollectionView.dataSource = self
        whatCollectionView.delegate = self
        let doneButton = UIBarButtonItem(title: "WHERE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(WhatViewController.doneTapped))
        navigationItem.rightBarButtonItem = doneButton

        let layout = whatCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "WHAT"
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
        return 4;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhatCell", forIndexPath: indexPath) as! WhatCollectionViewCell
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
    
    func doneTapped() {
        print("done")
        let layout = whatCollectionView.collectionViewLayout as! ImageCollectionViewLayout //layout.featuredItemIndex is the currently selected cell so we will need that here
        print(layout.featuredItemIndex)
        self.performSegueWithIdentifier("doneTapped", sender: self)
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
