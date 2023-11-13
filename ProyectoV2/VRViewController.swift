//
//  VRViewController.swift
//  ProyectoV2
//
//  Created by BigSur on 9/11/23.
//

import UIKit

class VRViewController: UIViewController {

    @IBOutlet weak var btnVisualizar: UIButton!
    @IBOutlet weak var btnRegistrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnVisualizar.layer.cornerRadius = 25.0
        btnRegistrar.layer.cornerRadius = 25.0
        
        // Crear un UIImageView con la imagen de fondo
        //let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
       //backgroundImage.image = UIImage(named: "4.png")
        //backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        //self.view.insertSubview(backgroundImage, at: 0)
        
    }
    


}
