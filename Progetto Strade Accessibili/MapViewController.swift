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
var posizioneIniziale:String!
var indirizzoIniziale:String!
var posizioneFinale:String!
var indirizzoFinale:String!
var locatio:[CLLocationCoordinate2D] = []
var aPolyline = MKPolyline()
var keyItinerario:String!
var coordinateItinerario: [CLLocationCoordinate2D] = []
class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    let locationManag = LocationManager.shared
  
    

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        locatio.append((locations.last?.coordinate)!)
        createPolyline()
        print("aggiunte",locatio.count,"coordinate")
        

        
//            func createPolyline(){
//            let polyline = MKPolyline(coordinates: &area, count: area.count)
////
//                mappa.add(polyline)   }
            
        }

  
    
    func createPolyline(){
//        let locations = [CLLocationCoordinate2D(latitude: 37.3321387, longitude: -122.0310386),CLLocationCoordinate2D(latitude: 37.3320003, longitude: -122.0319299)]
        //locations.append((locationManag.location?.coordinate)!)
        aPolyline = MKPolyline(coordinates: locatio, count: locatio.count)
        mappa.add(aPolyline,level: MKOverlayLevel.aboveRoads)
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
        
        locatio.removeAll()
        mappa.remove(aPolyline)
        
        locationManag.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManag.delegate = self
       
        locationManag.startUpdatingLocation()
        locationManag.startUpdatingHeading()
   

        mappa.delegate = self
        mappa.mapType = MKMapType.hybrid
        mappa.showsUserLocation = true
      
        mappa.mapType = MKMapType.hybrid
        mappa.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        let geoCoder = CLGeocoder()
        if let loc = locationManag.location{
            geoCoder.reverseGeocodeLocation(loc){(placemarks, error) in
                self.handlerIndirizzo(withPlacemarks: placemarks, error: error)
            } }
        if points.count != 0{
            for i in 0..<points.count{
                var annotat: MKPointAnnotation
                annotat = points[i].annotation
                mappa.addAnnotation(annotat)
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func stop(_ sender: Any) {
        locationManag.stopUpdatingLocation()
         coordinateItinerario = {
            
            var array = Array<CLLocationCoordinate2D>()
            for i in 0 ..< aPolyline.pointCount {
                
                let point = aPolyline.points()[i]
                
                array.append(MKCoordinateForMapPoint(point))
            }
            
            return array
        }()
        print("salvato itinerario con",coordinateItinerario.count, "coordinate")
        for element in coordinateItinerario {
            
            print("itinerario:",element)
        }
        print("posizione Salvata: ",posizioneIniziale)
        
        UserDefaults.standard.set(posizioneIniziale, forKey: "Posizione iniziale")
        
        let geoCoderFin = CLGeocoder()
        if let locfin = locationManag.location{
            geoCoderFin.reverseGeocodeLocation(locfin){(placemarks, error) in
                self.handlerIndirizzoFinale(withPlacemarks: placemarks, error: error)
            } }
//        if indirizzoFinale == nil {
//            print("posizione finale nulla")
//        }
       
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManag.delegate = nil
        mappa.delegate = nil

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handlerIndirizzo(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            
            posizioneIniziale = "Indirizzo non disponibile"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                posizioneIniziale = placemark.locality!
                indirizzoIniziale = placemark.thoroughfare!
                // locality = placemark.locality!
                //print(locality)
            } else {
                posizioneIniziale = "Indirizzo non disponibile "
            }
        }
    }
    func handlerIndirizzoFinale(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            
            posizioneFinale = "Indirizzo non disponibile"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                posizioneFinale = placemark.locality!
                indirizzoFinale = placemark.thoroughfare!
                // locality = placemark.locality!
                //print(locality)
                 storeCoordinates(coordinateItinerario)
            } else {
                posizioneFinale = "Indirizzo non disponibile "
            }
        }
    }
    
    
    // Store an array of CLLocationCoordinate2D
    func storeCoordinates(_ coordinates: [CLLocationCoordinate2D]) {
        let locations = coordinates.map { coordinate -> CLLocation in
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        let archived = NSKeyedArchiver.archivedData(withRootObject: locations)
        
        let number = counts[posizioneIniziale] ?? 0
//        if let num = number{
        
        
             keyItinerario = "\(posizioneIniziale!)\(number)"
            print(keyItinerario)
            UserDefaults.standard.set(archived, forKey: keyItinerario)
            UserDefaults.standard.synchronize()
        
            routes.append(route(da: indirizzoIniziale, a: indirizzoFinale, minuti: 42, chilometri: 42, loc: posizioneIniziale, itin: locations))
            let encodedData =
                NSKeyedArchiver.archivedData(withRootObject: routes)
            UserDefaults.standard.set(encodedData, forKey: "routes")
//        }
//        else{
//             keyItinerario = "\(posizioneIniziale!).0"
//            UserDefaults.standard.set(archived, forKey: keyItinerario)
//            UserDefaults.standard.synchronize()
//            routes.append(route(da: posizioneIniziale, a: keyItinerario, minuti: 42, chilometri: 42, loc: posizioneIniziale, itin:locations))
//            let encodedData =
//                NSKeyedArchiver.archivedData(withRootObject: routes)
//            UserDefaults.standard.set(encodedData, forKey: "routes")
//        }
        
    }
    
    // Return an array of CLLocationCoordinate2D
    func loadCoordinates() -> [CLLocationCoordinate2D]? {
        guard let archived = UserDefaults.standard.object(forKey: keyItinerario) as? Data,
            let locations = NSKeyedUnarchiver.unarchiveObject(with: archived) as? [CLLocation] else {
                return nil
        }
        
        let coordinates = locations.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        return coordinates
    }
    
    
    
}

