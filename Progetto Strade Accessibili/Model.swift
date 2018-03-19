//
//  Model.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 14/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation

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
//var listaItinerari = [String:Itinerari]()
//listaItinerari["Aversa"]=Itinerari(itinerari: locatio)


//var cpartenza: CLLocationCoordinate2D
//var cArrivo: CLLocationCoordinate2D


//cpartenza = coordinate_partenza
//cArrivo = coordinate_arrivo

//, coordinate_partenza:CLLocationCoordinate2D, coordinate_arrivo:CLLocationCoordinate2D

//, coordinate_partenza: CLLocationCoordinate2D(latitude: 40.98983, longitude: 14.20000), coordinate_arrivo: CLLocationCoordinate2D(latitude: 40.969696, longitude: 14.80201)

//, coordinate_partenza:CLLocationCoordinate2D(latitude: 49.90000, longitude: 14.1411441), coordinate_arrivo: CLLocationCoordinate2D(latitude: 40.181819, longitude: 10.404040)
