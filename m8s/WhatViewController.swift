//
//  WhatViewController.swift
//  m8s
//
//  Created by George Allen on 06/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase

class WhatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var whatCollectionView: UICollectionView!

    var whatItems = [WhatItem]()
    var whatItemRef: FIRDatabaseReference!
    var handle: UInt!
    var imageSubscriptionId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.whatItemRef = FIRDatabase.database().reference().child("what-items")
        
        whatCollectionView.dataSource = self
        whatCollectionView.delegate = self
        let doneButton = UIBarButtonItem(title: "WHERE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(WhatViewController.doneTapped))
        navigationItem.rightBarButtonItem = doneButton

        let layout = whatCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "WHAT"
        
        self.imageSubscriptionId = StorageService.subscribe(StorageService.Key.Images, callback: {
            print("reloading data")
            self.fetchWhatItems()
        })
        
        self.fetchWhatItems()
    }
    
    private func fetchWhatItems() {
        self.unFetchWhatItems()
        self.handle = self.whatItemRef.observeEventType(.Value, withBlock: { snapshot in
            var newItems = [WhatItem]()
            for item in snapshot.children {
                let name = item.value["name"] as! String
                let imageKey = item.value["imageKey"] as! String
                let whatItem = WhatItem(name: name, imageKey: imageKey, key: item.key)
                newItems.append(whatItem)
            }
            self.whatItems = newItems
            self.whatCollectionView.reloadData()
        })
    }
    
    private func unFetchWhatItems(){
        if let whatItemRef = self.whatItemRef {
            if let handle = self.handle {
                whatItemRef.removeObserverWithHandle(handle)
            }
        }
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.unFetchWhatItems()
        StorageService.unsubscribe(self.imageSubscriptionId)
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
        return self.whatItems.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhatCell", forIndexPath: indexPath) as! WhatCollectionViewCell
        
        let whatItem = self.whatItems[indexPath.row]
        cell.label?.text = whatItem.name
        
        if let image = StorageService.getImageWithKey(whatItem.imageKey) {
             cell.imageView.image = image.uiimage
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
