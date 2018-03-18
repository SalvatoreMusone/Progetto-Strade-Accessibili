//
//  ViewItinerario.swift
//  Progetto Strade Accessibili
//
//  Created by Davide Panettieri on 17/03/18.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewItinerario: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mappaItinerario: MKMapView!
    
    let locationManag = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
         mappaItinerario.delegate = self
        locationManag.delegate = self
        mappaItinerario.showsUserLocation = true
        mappaItinerario.mapType = MKMapType.hybrid
         mappaItinerario.userTrackingMode = MKUserTrackingMode.followWithHeading
        createPolyline()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManag.delegate = nil
        mappaItinerario.delegate = nil
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer!{
        
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.red.withAlphaComponent(0.5)
            pr.lineWidth = 5
            return pr
        }
        return nil
        
        
    }
    
    func loadCoordinates() -> [CLLocationCoordinate2D]? {
       
        let locations = itinerarioSelezionato.itin
        
        
        let coordinates = locations.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        return coordinates
    }
    
    
    func createPolyline(){
        
       let coordinateItinerario = loadCoordinates()
        
        
        let polylineItinerario = MKPolyline(coordinates: coordinateItinerario!, count: (coordinateItinerario?.count)!)
        mappaItinerario.add(polylineItinerario,level: MKOverlayLevel.aboveRoads)
    }

}
