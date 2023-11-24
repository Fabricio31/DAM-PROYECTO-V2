import UIKit
import Photos

class AddStudentVC: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtStd: UITextField!
    @IBOutlet weak var txtSchool: UITextField!
    var imageView: UIImageView!
    var selectImageButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        // Agregar el UIImageView
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(self.imageView)

        // Agregar el botón para seleccionar la imagen
        self.selectImageButton = UIButton(type: .system)
        self.selectImageButton.setTitle("Seleccionar imagen", for: .normal)
        self.selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        self.view.addSubview(self.selectImageButton)

        // Ajustar la posición y el tamaño del UIImageView y del botón
        let margin: CGFloat = 20
        let buttonHeight: CGFloat = 44
        let imageViewHeight = self.view.bounds.height - margin * 4 - buttonHeight
        self.imageView.frame = CGRect(x: margin, y: margin, width: self.view.bounds.width - margin * 2, height: imageViewHeight)
        self.selectImageButton.frame = CGRect(x: margin, y: self.imageView.frame.maxY + margin, width: self.view.bounds.width - margin * 2, height: buttonHeight)
    }

    @objc func selectImage() {
        let alert = UIAlertController(title: "Seleccionar imagen", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { _ in
            self.showImagePicker(sourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: { _ in
            self.showImagePicker(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true, completion: nil)
    }

    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    @IBAction func onClickAdd(_ sender: Any) {
        guard let name = txtName.text, !name.isEmpty,
              let std = txtStd.text, !std.isEmpty,
              let school = txtSchool.text, !school.isEmpty else {
            // Mostrar una alerta si algún campo está vacío
            let alert = UIAlertController(title: "Error", message: "Por favor, complete todos los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        // Si todos los campos están completos, continuar con la lógica para agregar el estudiante
        let newStudent = Student(context: DBManager.share.context)
        newStudent.name = name
        newStudent.std = std
        newStudent.school = school
        // Agregar la imagen a la base de datos
        if let image = imageView.image {
        }
        DBManager.share.saveContext()

        // Limpiar los campos de texto
        txtName.text = ""
        txtStd.text = ""
        txtSchool.text = ""

        // Mostrar mensaje emergente
        let successAlert = UIAlertController(title: "Éxito", message: "La Noticia se ha registrado exitosamente!", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.imageView.image = nil // Limpiar la imagen
        }))
        self.present(successAlert, animated: true, completion: nil)
    }
}

extension AddStudentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let resizedImage = image.resizeImage(targetSize: CGSize(width: image.size.width / 2, height: image.size.height / 2)) // Redimensionar la imagen al 50%
            self.imageView.image = resizedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
}
