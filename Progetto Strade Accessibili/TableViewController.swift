//
//  TableViewController.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 15/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import CoreLocation
var localitycell=""
class TableViewController: UITableViewController {
    let geoCoder = CLGeocoder()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   // override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
   //     return 1
   // }
    func geocode(){
        
        let locationManag = LocationManager.shared
        
        
        if let loc = locationManag.location{
            geoCoder.reverseGeocodeLocation(loc){(placemarks, error) in
                self.handlerIndirizzo(withPlacemarks: placemarks, error: error)
            } }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as! TableViewCell
        let i = indexPath.row
        
    
        
        
        geocode()
//        if locality == routes[i].locality{
//            //print(locality)

        cell.Arrivo.text = "Arrivo: \(routes[i].tarrivo)"
        cell.Partenza.text = "Da: \(routes[i].tpartenza)"
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
       // print("prova \(i)")
        return cell
    
    }
    func handlerIndirizzo(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            
            localitycell = "Indirizzo non disponibile"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                localitycell = "Location:  \(placemark.locality!), \(placemark.country!)"
                localitycell = placemark.locality!
                //print(localitycell)

            } else {
                localitycell = "Indirizzo non disponibile "
            }
        }
    }
/*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let nuova = routes.remove(at: fromIndexPath.row)
        routes.insert(nuova, at: to.row)
    }
*/
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
            if(editingStyle == .delete)
            {
                print("delete row at \(indexPath)")
                routes.remove(at: indexPath.row);
                
                tableView.deleteRows( at: [indexPath], with: .left)
                
            }
            
        }
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let i = tableView.indexPathForSelectedRow!.row
        itinerarioSelezionato = routes[i]
    }
   

}
