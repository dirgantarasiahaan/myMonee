//
//  AddImpianViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class AddImpianViewController: UIViewController {

    @IBOutlet weak var txtJudul: UITextField!
    @IBOutlet weak var txtTarget: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapButtonSimpan(){
        let vc = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        impian.insert(Impian(id: impian.count+1, lblName: txtJudul.text, lblPrice: "0", priceTarget: txtTarget.text, progress: 0.0), at: 0)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(impian), forKey: "arrayImpian")
        navigationController?.setViewControllers([vc], animated: true)
    }

}
