//
//  AddPoint.swift
//  Progetto Strade Accessibili
//
//  Created by Gianmichele Persico on 19/03/18.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var coordinate = CLLocationCoordinate2D()
class AddPoint: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate {
    @IBOutlet var foto: UIImageView!
    let locationManager = LocationManager.shared
    
    
    @IBOutlet var tnewpoint: UITextField!
    
    @IBOutlet var descrizione: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
     locationManager.delegate = self
        if let loc = locationManager.location{
            coordinate = loc.coordinate
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func inseriscifoto(_ sender: Any) {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        foto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func Salva(_ sender: Any) {
        let newpoint = MKPointAnnotation()
        newpoint.coordinate = coordinate
        
        
        newpoint.title = tnewpoint.text!
        newpoint.subtitle = descrizione.text!
        print(tnewpoint.text!)
        print(descrizione.text)
        print("---------")
        print(newpoint.title!)
        print(newpoint.subtitle!)
        points.append(Point(annotation: newpoint, immagine: foto.image!))
        
        
    }
    
}
