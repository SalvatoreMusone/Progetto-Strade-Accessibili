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
    @IBOutlet var lpartenza: UILabel!
    @IBOutlet var ldestinazione: UILabel!
    let locationManag = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mappaItinerario.delegate = self
        locationManag.delegate = self
        mappaItinerario.showsUserLocation = true
        mappaItinerario.mapType = MKMapType.hybrid
        mappaItinerario.userTrackingMode = MKUserTrackingMode.followWithHeading
        createPolyline()
        
        ldestinazione.text = "Arrivo: \(itinerarioSelezionato.tarrivo)"
        lpartenza.text = "Partenza: \(itinerarioSelezionato.tpartenza)"
        // Do any additional setup after loading the view.
        if pooints.count != 0{
            for i in 0..<pooints.count{
                var annotat = MKPointAnnotation()
                
                annotat.coordinate = pooints[i].location.coordinate as CLLocationCoordinate2D
                annotat.title = pooints[i].title
                annotat.subtitle = pooints[i].subtitle
                
                //                annotat = pooints[i].annotation
                mappaItinerario.addAnnotation(annotat)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManag.delegate = nil
        mappaItinerario.delegate = nil
        
    }
    
    
    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer!{
        
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.red.withAlphaComponent(0.5)
            pr.lineWidth = 5
            return pr
        }
        return nil
        
        
    }
    


//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
//        if annotation.coordinate.latitude != pooints[0].location.coordinate.latitude && annotation.coordinate.longitude != pooints[0].location.coordinate.longitude
//        {return nil}
//        let av = MKAnnotationView(annotation: annotation, reuseIdentifier: "l")
//        av.canShowCallout = true
//        av.image = #imageLiteral(resourceName: "back")
//        av.frame.size = CGSize(width: 96, height: 96)
//    
//        return av
//    }
    
    
    
    
    
    func loadCoordinatesPoint() -> [CLLocationCoordinate2D]? {
        
        let locations = itinerarioSelezionato.itin
        
        
        let coordinates = locations.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        return coordinates
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

