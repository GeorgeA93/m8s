//
//  WhenViewController.swift
//  m8s
//
//  Created by George Allen on 28/03/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WhenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private weak var whenCollectionView: UICollectionView!
    @IBOutlet private weak var revealButton: UIBarButtonItem!
    
    var whenItems = [WhenItem]()
    var whenItemRef: FIRDatabaseReference!
    var handle: UInt!
    var imageSubscriptionId: String!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.whenItemRef = FIRDatabase.database().reference().child("when-items")

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
        self.imageSubscriptionId = StorageService.subscribe(StorageService.Key.Images, callback: {
            print("reloading data")
            self.fetchWhenItems()
        })
        self.fetchWhenItems()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.whenCollectionView.setContentOffset(CGPointZero, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.unFetchWhenItems()
        StorageService.unsubscribe(self.imageSubscriptionId)
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchWhenItems() {
        self.unFetchWhenItems()
        self.handle = self.whenItemRef.observeEventType(.Value, withBlock: { snapshot in
            var newItems = [WhenItem]()
            for item in snapshot.children {
                let name = item.value["name"] as! String
                let imageKey = item.value["imageKey"] as! String
                let whenItem = WhenItem(name: name, imageKey: imageKey, key: item.key)
                newItems.append(whenItem)
            }
            print(self.getDayOfWeek())
            self.whenItems = newItems
            self.whenCollectionView.reloadData()
        })
    }
    
    private func unFetchWhenItems(){
        if let whenItemRef = self.whenItemRef {
            if let handle = self.handle {
                whenItemRef.removeObserverWithHandle(handle)
            }
        }
    }
    
    private func getDayOfWeek() -> String {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let components = calendar.components(.Weekday, fromDate: NSDate())
        return components.weekday.toWeekday()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whenItems.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WhenCell", forIndexPath: indexPath) as! WhenCollectionViewCell
        let whenItem = self.whenItems[indexPath.row]
        cell.label?.text = whenItem.name
        
        if let image = StorageService.getImageWithKey(whenItem.imageKey) {
            cell.imageView.image = image.uiimage
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



