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
        
        let layout = whenCollectionView.collectionViewLayout as! WhenCollectionViewLayout
        layout.prepareLayout()
       
        //uncoment for a nice image behind the collection view cells
        //whenCollectionView.backgroundView = UIImageView(image: UIImage(named:"city2"));
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        revealButton!.target = self.revealViewController()
        revealButton!.action = #selector(SWRevealViewController.revealToggle(_:))
        
        navigationController!.navigationBar.backgroundColor = UIColor(red:48.0/255.0 ,green:131.0/255.0 ,blue:160.0/255.0, alpha:1.0)
        navigationController!.navigationBar.barTintColor = UIColor(red:48.0/255.0 ,green:131.0/255.0 ,blue:160.0/255.0, alpha:1.0)
        
        if let user = Services.userService.currentUser {
            print(user.fullName)
        } else {
           
        }
        
        let loginButton = Services.userService.CreateFbLoginButton()
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton);
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
            cell.dayLabel!.text = "TODAY";
             cell.imageView!.image = UIImage(named: "city7");
        } else if(indexPath.row == 1){
            cell.dayLabel!.text = "TOMORROW";
             cell.imageView!.image = UIImage(named: "city2");
            
        } else if(indexPath.row == 2){
            cell.dayLabel!.text = "FRIDAY";
             cell.imageView!.image = UIImage(named: "city3");
            
        }else if(indexPath.row == 3){
            cell.dayLabel!.text = "SATURDAY";
             cell.imageView!.image = UIImage(named: "city4");
            
        }else if(indexPath.row == 4){
            cell.dayLabel!.text = "SUNDAY";
             cell.imageView!.image = UIImage(named: "city5");
            
        }else if(indexPath.row == 5){
            cell.dayLabel!.text = "MONDAY";
             cell.imageView!.image = UIImage(named: "city6");
            
        }else if(indexPath.row == 6){
            cell.dayLabel!.text = "TUESDAY";
             cell.imageView!.image = UIImage(named: "city3");
            
        } else {
            cell.dayLabel!.text = "TODAY";
             cell.imageView!.image = UIImage(named: "city");
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = whenCollectionView.collectionViewLayout as! WhenCollectionViewLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
}

