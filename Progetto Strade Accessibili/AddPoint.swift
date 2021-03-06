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
var location = CLLocation()
class AddPoint: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate {
    @IBOutlet var foto: UIImageView!
    let locationManager = LocationManager.shared
    
    
    @IBOutlet var tnewpoint: UITextField!
    
    @IBOutlet var descrizione: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
       self.hideKeyboardWhenTappedAround()
        
        if let loc = locationManager.location{
            location = loc
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
    
    
    @IBAction func scatta(_ sender: Any) {
        
        let ipc = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        ipc.sourceType = .camera
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
        }else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func imagePickerControllere(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
        print("---------")
        
        
        
        
        
        pooints.append(Pooint(location: location, title: newpoint.title!, subtitle: newpoint.subtitle!, immagine: foto.image!))
        //points.append(Point(annotation: newpoint, immagine: foto.image!))
        let encodedData =
            NSKeyedArchiver.archivedData(withRootObject: pooints)
        UserDefaults.standard.set(encodedData, forKey: "pooints")
        
        
    }
   
    @IBAction func nascondiTastiera() {
        tnewpoint.resignFirstResponder()
        descrizione.resignFirstResponder()
       
    }
    
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
