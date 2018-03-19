//
//  Homepage.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 16/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation
var counts=[String : Int]()
var listaCaricata = [route]()
var posizioneWelcome=""
class Homepage: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var welcome: UILabel!
    let locationManag = LocationManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let geoCoder = CLGeocoder()
        if let loc = locationManag.location{
            geoCoder.reverseGeocodeLocation(loc){(placemarks, error) in
                self.handlerIndirizzo(withPlacemarks: placemarks, error: error)
                
            } }
        
       
//        var mapV = MapViewController()
//        var itinerarioSalv = mapV.loadCoordinates()
//        print(itinerarioSalv)
        if let posizione = UserDefaults.standard.value(forKey: "Posizione iniziale") as? String{
            print(posizione)
//            routes.append(route(da: posizione, a: "Infinito ed oltre", minuti: 42, chilometri: 42, loc: posizione, itin: itinerarioSalv!))
            
            
            
            if let data = UserDefaults.standard.data(forKey: "routes"),
                let lista = NSKeyedUnarchiver.unarchiveObject(with: data) as? [route] {
                routes.removeAll()
                 lista.forEach({
                    
                routes.append(route(da: $0.tpartenza, a: $0.tarrivo, minuti: $0.minuti, chilometri: $0.chilometri, loc: $0.locality, itin: $0.itin))
                    
                    
                    
                    print( $0.tpartenza, $0.tarrivo)
                    
                 })
                
            } else {
                print("Errore")
            }
            
            // conta gli itinerari per ogni locality
            var arrayLocal:[String] = []
            for route in routes{
                arrayLocal.append(route.locality)
            }
            counts = arrayLocal.reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
            print(counts)

          
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewDidAppear(_ animated: Bool) {
//
//        if posizioneWelcome == ""{
//            self.viewDidLoad()
//        }
//
//        }
    override func viewDidAppear(_ animated: Bool) {
        if posizioneWelcome==""{
            self.viewDidLoad()
        }
    }
   
//    override func viewWillAppear(_ animated: Bool) {
//        if posizioneWelcome==""{
//            self.viewDidLoad()
//        }
//           }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func handlerIndirizzo(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            
            welcome.text = "Indirizzo non disponibile"
            posizioneWelcome = "Indirizzo non disponibile"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                welcome.text = "Welcome to:  \(placemark.locality!), \(placemark.country!)"
                posizioneWelcome = "Welcome to:  \(placemark.locality!), \(placemark.country!)"
                // locality = placemark.locality!
                //print(locality)
            } else {
                welcome.text = "Indirizzo non disponibile "
                posizioneWelcome = "Indirizzo non disponibile "
            }
        }
}
}
