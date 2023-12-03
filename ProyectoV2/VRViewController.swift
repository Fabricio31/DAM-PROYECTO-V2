import UIKit
import Firebase

class VRViewController: UIViewController {

    @IBOutlet weak var btnVisualizar: UIButton!
    @IBOutlet weak var btnRegistrar: UIButton!
    @IBOutlet weak var welcomelabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnVisualizar.layer.cornerRadius = 25.0
        btnRegistrar.layer.cornerRadius = 25.0

        if let userEmail = Auth.auth().currentUser?.email {
            let welcomeMessage = "Bienvenido " + userEmail
            welcomelabel.text = welcomeMessage
        }
    }

    @IBAction func botonCerrarSesionTocado(_ sender: UIButton) {
        mostrarAlertaSalir()
    }

    func cerrarSesion() {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }

    func navegarAInicioDeSesion() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }

    func mostrarAlertaSalir() {
        let alerta = UIAlertController(title: "¿Deseas salir?", message: nil, preferredStyle: .alert)

        let accionSi = UIAlertAction(title: "Sí", style: .default) { _ in
            self.cerrarSesion()
            self.navegarAInicioDeSesion()
        }

        let accionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alerta.addAction(accionSi)
        alerta.addAction(accionNo)

        present(alerta, animated: true, completion: nil)
    }
}

