//
//  EditProfileViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var btnEditImage: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEditName: UIButton!
    @IBOutlet weak var textName: UITextField!
    public var completionHandler: ((String?) -> Void)?
    var defaultName: String! = ""
    var imageTemp: UIImage? = UIImage(named: profile.imageProfile!)
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEditImage.isHidden = true
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width/2
        imageProfile.clipsToBounds = true
        imageProfile.image = UIImage().resizeImage(image: imageTemp!, newWidth: 100.0)
        lblName.text = defaultName
        
        imageProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeImageFromGalery)))
    }
    
    @objc func changeImageFromGalery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapButtonSelesai(){
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.passName = lblName.text!
        vc.image = imageTemp

        navigationController?.setViewControllers([vc], animated: true)
    }
    
    @IBAction func btnEditName(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Username", message: "Masukkan Username Baru", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = self.defaultName
        }
        
        let cancelAction = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Simpan", style: .default) { _ in
            let inputName = alertController.textFields![0].text
            self.defaultName = inputName!
            let vc = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
            vc.defaultName = self.defaultName
            self.viewDidLoad()
            
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
        
    @IBAction func didTapButton(){
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        vc.passName = lblName.text!
    }
    
    @IBAction func didTapEditImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
        vc.allowsEditing = false
        present(vc, animated: true, completion: nil)
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             
        picker.dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else {fatalError()}
            UserDefaults.standard.setValue(image.pngData(), forKey: "imageDesc")
            self.imageProfile.image = UIImage(data: image.pngData() ?? Data())
            self.imageProfile.image = UIImage().resizeImage(image: image, newWidth: 100)
            self.imageTemp = image
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension UIImage {
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    
}
