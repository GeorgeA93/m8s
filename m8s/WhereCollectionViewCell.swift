//
//  WhereCollectionViewCell.swift
//  m8s
//
//  Created by George Allen on 17/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class WhereCollectionViewCell: ImageCollectionViewCell {

    var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 2000
    var locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    @IBOutlet weak var labelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        backButton.alpha = delta
        forwardButton.alpha = delta
        
        //move map and label
        if(delta > 0){
            if let map = mapView {
                labelCenterYConstraint?.active = false
                label.frame = CGRect(x: label.frame.minX, y: 8 / delta, width: label.frame.width, height: label.frame.height)
                map.frame = CGRect(x: 0, y: label.frame.maxY, width: frame.size.width, height: frame.height - label.frame.maxY)
            }
        } else {
            if let map = mapView {
                labelCenterYConstraint?.active = true
                map.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
            }
        }
    }

    func setupMapView() {
        let mapViewFrame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
        mapView = MKMapView(frame: mapViewFrame)
        addSubview(mapView)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //load location search table
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let locationSearchTable = storyboard.instantiateViewControllerWithIdentifier("LocationSearchTableViewController") as! LocationSearchTableViewController
        locationSearchTable.view.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        //create the search controller
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        //create the search bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        //add the map to the view
        mapView.addSubview(searchBar)
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        //set the initial location
        let initialLocation = CLLocation(latitude: 51.50007773, longitude: -0.1246402) //set the initial location to london
        centerMapOnLocation(initialLocation)
    }
    
    // MARK: Map View
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func forwardButtonTap(sender: AnyObject) {
        print("forward")
    }

    @IBAction func backButtonTap(sender: AnyObject) {
        print("back")
    }
}

extension WhereCollectionViewCell : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}

extension WhereCollectionViewCell: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension WhereCollectionViewCell : MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orangeColor()
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), forState: .Normal)
        //button.addTarget(self, action: "getDirections", forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
