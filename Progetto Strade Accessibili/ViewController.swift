//
//  ViewController.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 14/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    let locationManag = LocationManager.shared
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200)
        mappa.setRegion(coordinateRegion, animated: true)
        let location = userLocation
        
        print(location.coordinate)
        
        
        
        
        
        
    }
    @IBOutlet weak var mappa: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mappa.delegate = self
        mappa.mapType = MKMapType.hybrid
        mappa.showsUserLocation = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

