//
//  Model.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 14/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
//struct Itinerari{
//    var itinerari: Array<Array<CLLocationCoordinate2D>> = []
//
//
//
//}


class route: NSObject, NSCoding {
    var tpartenza: String
    var tarrivo: String
    var minuti: Int
    var chilometri: Double
    var locality:String
    var itin: [CLLocation]
    init(da: String, a: String, minuti: Int, chilometri: Double, loc:String , itin: [CLLocation] ) {
        tpartenza = da
        tarrivo = a
        self.minuti = minuti
        self.chilometri = chilometri
        self.locality = loc
        self.itin = itin
        //         var it = Itinerari()
        //
        //        it.itinerari.append(locatio)
    }
    
    
    required init(coder decoder: NSCoder) {
        self.tpartenza = decoder.decodeObject(forKey: "partenza") as? String ?? ""
        self.tarrivo = decoder.decodeObject(forKey: "arrivo") as? String ?? ""
        self.minuti = decoder.decodeInteger(forKey: "minuti")
        self.chilometri = decoder.decodeDouble(forKey: "chilometri")
        self.locality = decoder.decodeObject(forKey: "locality") as? String ?? ""
        self.itin = decoder.decodeObject(forKey: "itin") as? [CLLocation] ?? [CLLocation()]
        
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(tpartenza, forKey: "partenza")
        coder.encode(tarrivo, forKey: "arrivo")
        coder.encode(minuti, forKey: "minuti")
        coder.encode(chilometri, forKey: "chilometri")
        coder.encode(locality, forKey: "locality")
        coder.encode(itin, forKey: "itin")
    }
    
    
    
    
    
}

var routes: [route] = []


var itinerarioSelezionato:route!

struct Point{
    var annotation: MKPointAnnotation
    var immagine: UIImage
    
}
class Pooint: NSObject, NSCoding {
    var location:CLLocation
    var title:String
    var subtitle:String
    var immagine: UIImage
    
    init(location:CLLocation,title:String,subtitle:String ,immagine:UIImage){
        self.location = location
        self.title = title
        self.subtitle = subtitle
        self.immagine = immagine
    }
    
    required init(coder decoder: NSCoder) {
        self.location = decoder.decodeObject(forKey: "location") as? CLLocation ?? CLLocation()
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.subtitle = decoder.decodeObject(forKey: "subtitle") as? String ?? ""
        self.immagine = decoder.decodeObject(forKey: "immagine") as? UIImage ?? UIImage()
        
        
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(location, forKey: "location")
        coder.encode(title, forKey: "title")
        coder.encode(subtitle, forKey: "subtitle")
        coder.encode(immagine, forKey: "immagine")
        
    }
    
    
}

//model del point of interest
var points: [Point] = [
]

var pooints: [Pooint] = []
