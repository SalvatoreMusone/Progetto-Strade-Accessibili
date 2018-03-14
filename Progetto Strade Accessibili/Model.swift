//
//  Model.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 14/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
class routes {
    var partenza: String
    var arrivo: String
    var minuti: Int
    var chilometri: Int
    
    init(da: String, a: String, minuti: Int, chilometri: Int ) {
        partenza = da
        arrivo = a
        self.minuti = minuti
        self.chilometri = chilometri
    }
}
