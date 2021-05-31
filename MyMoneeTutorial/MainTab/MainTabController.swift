//
//  MainTabController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 11/05/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    
    var username: String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        username = profile.name

        self.tabBar.barTintColor = .white
        
        let home = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        
        homeTab.tabBarItem = UITabBarItem(title: "Beranda", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        homeTab.tabBarItem.tag = 0
        
        
        let impian = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        let impianTab = UINavigationController(rootViewController: impian)
        let impianImage = UIImage(named: "Impian")?.withRenderingMode(.alwaysOriginal)
        let impianImageSelected = UIImage(named: "ImpianSelected")?.withRenderingMode(.alwaysOriginal)
        
        impianTab.tabBarItem = UITabBarItem(title: "Impian", image: impianImage, selectedImage: impianImageSelected)
        impianTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        impianTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        impianTab.tabBarItem.tag = 1
        
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)
//        let profileImageSeletedTest = UIImage(named: "Profile")?.withTintColor(.red)
        
        profileTab.tabBarItem = UITabBarItem(title: "Profil", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        profileTab.tabBarItem.tag = 2
       

        self.viewControllers = [homeTab, impianTab, profileTab]
  
    }
    
    override func viewWillAppear( _ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

    override func viewWillDisappear( _ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
