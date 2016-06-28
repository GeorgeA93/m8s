//
//  WhereViewController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import MapKit


class WhereViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var whereCollectionView: UICollectionView!
    var workingPlan: Plan!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        whereCollectionView.dataSource = self
        whereCollectionView.delegate = self
        
        let doneButton = UIBarButtonItem(title: "INVITE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(WhereViewController.doneTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        let layout = whereCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "WHERE"
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionView
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhereCell", forIndexPath: indexPath) as! WhereCollectionViewCell
        if(indexPath.row == 0){
            cell.label!.text = "ANYWHERE";
            cell.imageView!.image = UIImage(named: "city7");
        } else { //the last cell will be the map view
            cell.label!.text = "SPECIFIC";
            cell.imageView!.image = UIImage(named: "city4");
            cell.setupMapView()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = whereCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
    
    func doneTapped() {
       // let layout = whereCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        
        let cell = whereCollectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! WhereCollectionViewCell
        print(cell.selectedPin?.region)
        
        self.performSegueWithIdentifier("doneTapped", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneTapped" {
            let inviteViewController = segue.destinationViewController as! InviteFriendsViewController
            inviteViewController.workingPlan = self.workingPlan
        }
    }

}