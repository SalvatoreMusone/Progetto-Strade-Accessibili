//
//  Model.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 14/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation


class route {
    var tpartenza: String
    var tarrivo: String
    var minuti: Int
    var chilometri: Double
    var locality:String
    
    init(da: String, a: String, minuti: Int, chilometri: Double, loc:String ) {
        tpartenza = da
        tarrivo = a
        self.minuti = minuti
        self.chilometri = chilometri
        self.locality = loc
    }
}

var routes = [
    route(da: "Casa", a: "Università", minuti: 20, chilometri: 2.7 , loc: "Aversa"),
    route(da: "Annunziata", a: "Aulario", minuti: 15, chilometri: 10.2, loc:"Marcianise"),
]

//var cpartenza: CLLocationCoordinate2D
//var cArrivo: CLLocationCoordinate2D


//cpartenza = coordinate_partenza
//cArrivo = coordinate_arrivo

//, coordinate_partenza:CLLocationCoordinate2D, coordinate_arrivo:CLLocationCoordinate2D

//, coordinate_partenza: CLLocationCoordinate2D(latitude: 40.98983, longitude: 14.20000), coordinate_arrivo: CLLocationCoordinate2D(latitude: 40.969696, longitude: 14.80201)

//, coordinate_partenza:CLLocationCoordinate2D(latitude: 49.90000, longitude: 14.1411441), coordinate_arrivo: CLLocationCoordinate2D(latitude: 40.181819, longitude: 10.404040)
