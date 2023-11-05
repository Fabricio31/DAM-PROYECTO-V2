//
//  RestViewController.swift
//  ProyectoV2
//
//  Created by BigSur on 4/11/23.
//

import UIKit

class RestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        APICaller.shared.getTopStories{
            result in
        }
        
        
        
        mostrarMensaje()
    }
    
    
    
    
    
    
    
    
    func mostrarMensaje() {
        // Crear una instancia de UIAlertController
        let alertController = UIAlertController(title: "¡Hola!", message: "Este es un mensaje de ejemplo", preferredStyle: .alert)
        // Crear una acción de "Aceptar" para la alerta
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        // Agregar la acción de "Aceptar" a la alerta
        alertController.addAction(okAction)
        // Presentar la alerta
        present(alertController, animated: true, completion: nil)
    }
    

  

}
