//
//  ProfileViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit
//import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    
    var passName: String! = profile.name
    var image: UIImage! = UIImage(named: profile.imageProfile!)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profil"
        
        let tabBar = tabBarController as! MainTabController
        txtName.text = String(describing: tabBar.username!)
        
        if txtName.text != nil {
            txtName.text = String(describing: tabBar.username!)
        }        
        
        if let imageData = UserDefaults.standard.object(forKey: "imageDesc") as? Data {
            imageProfile.image = UIImage(data: imageData)
            imageProfile.image = UIImage().resizeImage(image: UIImage(data: imageData)!, newWidth: 100)
            imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
            imageProfile.clipsToBounds = true
            image = UIImage(data: imageData)!
        } else {
            imageProfile.image = UIImage(systemName: profile.imageProfile!)
        }
//        let url  = URL(string: "https://purepng.com/public/uploads/large/purepng.com-mariomariofictional-charactervideo-gamefranchisenintendodesigner-1701528634653vywuz.png")
//
//        imageProfile.kf.setImage(with: url)
        
        
        

    }

    @IBAction func didTapButton(){
        let vc = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
        vc.defaultName = txtName.text!
        vc.imageTemp = image

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handle_pan(_ gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtName.text = String(describing: passName!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabController
        tabBar.username = passName!
    }
}
