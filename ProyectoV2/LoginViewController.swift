import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Por favor, ingrese su correo electrónico")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Por favor, ingrese su contraseña")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            // El usuario ha iniciado sesión correctamente
            if let userEmail = Auth.auth().currentUser?.email {
            print("Bienvenido \(userEmail)")}
            self.performSegue(withIdentifier: "goToNext", sender: self)
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
