//
//  Homepage.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 16/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation

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
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                welcome.text = "Welcome to:  \(placemark.locality!), \(placemark.country!)"
                // locality = placemark.locality!
                //print(locality)
            } else {
                welcome.text = "Indirizzo non disponibile "
            }
        }
}
}
