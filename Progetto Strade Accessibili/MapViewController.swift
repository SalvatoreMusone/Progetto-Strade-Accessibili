//
//  MapViewController.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 15/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    let locationManag = LocationManager.shared
  
    
   
   var locatio:[CLLocationCoordinate2D] = []

    

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        locatio.append((locations.last?.coordinate)!)
        createPolyline()
        print("present location : (newLocation.coordinate.latitude), (newLocation.coordinate.longitude)")
        

        
//            func createPolyline(){
//            let polyline = MKPolyline(coordinates: &area, count: area.count)
////
//                mappa.add(polyline)   }
            
        }

  
    
    func createPolyline(){
//        let locations = [CLLocationCoordinate2D(latitude: 37.3321387, longitude: -122.0310386),CLLocationCoordinate2D(latitude: 37.3320003, longitude: -122.0319299)]
        //locations.append((locationManag.location?.coordinate)!)
        let aPolyline = MKPolyline(coordinates: locatio, count: locatio.count)
        mappa.add(aPolyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer!{
        
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.red.withAlphaComponent(0.5)
            pr.lineWidth = 5
            return pr
        }
        return nil

        
    }
   
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200)
//        mappa.setRegion(coordinateRegion, animated: true)
//        let location = userLocation
//
//        print(location.coordinate)
//
//        }

    @IBOutlet weak var mappa: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManag.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManag.delegate = self
       
        locationManag.startUpdatingLocation()
        locationManag.startUpdatingHeading()
        

        mappa.delegate = self
        mappa.mapType = MKMapType.hybrid
        mappa.showsUserLocation = true
      
        
        
        mappa.mapType = MKMapType.hybrid
        mappa.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

