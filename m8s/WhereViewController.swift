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
    let regionRadius: CLLocationDistance = 2000
    var mapView = MKMapView()
    var locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whereCollectionView.dataSource = self
        whereCollectionView.delegate = self
        
        let layout = whereCollectionView.collectionViewLayout as! ImageCollectionViewLayout
        layout.prepareLayout()
        
      //  locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.requestWhenInUseAuthorization()
       // locationManager.requestLocation()
        checkLocationAuthorizationStatus()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem("WHERE")
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
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
    
    // MARK: - location manager
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}