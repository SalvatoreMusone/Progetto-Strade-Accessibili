//
//  AddPoint.swift
//  Progetto Strade Accessibili
//
//  Created by Gianmichele Persico on 19/03/18.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit

class AddPoint: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var foto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
         ipc.sourceType = .camera
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    
    func imagePickerControllere(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        foto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }

    
    
    }



