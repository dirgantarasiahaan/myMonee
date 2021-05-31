//
//  EditImpianViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 13/05/21.
//

import UIKit



class EditImpianViewController: UIViewController {

    @IBOutlet weak var txtTarget: UITextField!
    @IBOutlet weak var txtJudul: UITextField!
    @IBOutlet weak var txtAddMoney: UITextField!
    
    var id: Int! = nil
    var target: String! = ""
    var judul: String! = ""
    var money: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTarget.text = target
        txtJudul.text = judul
        
    }


    @IBAction func didTapButtonPerbarui(){
        
        let indexPath: Int! = IndexImpian().get(id: self.id)
        var impianUpdate = impian[indexPath]
        impianUpdate.id = impian[indexPath].id
        impianUpdate.lblName = txtJudul.text!
        
        money = (txtAddMoney.text! as NSString).integerValue + (impian[indexPath].lblPrice! as NSString).integerValue
        
        impianUpdate.lblPrice = String(money)
        impianUpdate.priceTarget = txtTarget.text
        impianUpdate.progress = ((impian[indexPath].lblPrice! as NSString).floatValue +
                                    (txtAddMoney.text! as NSString).floatValue) / (txtTarget.text! as NSString).floatValue
        impian[IndexImpian().get(id: self.id)] = impianUpdate
        
        let vc = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(impian), forKey: "arrayImpian")
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    @IBAction func didTapButtonHapus(){
        
        let alert = UIAlertController(title: "Menghapus Impian", message: "Apakah anda yakin ingin mengahapus ''\(judul!)''?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {action in
      
            impian.remove(at: IndexImpian().get(id: self.id))
            print("tapped delete")
            
            let vc = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
//            UserDefaults.standard.set(try? PropertyListEncoder().encode(impian), forKey: "arrayImpian")
            self.navigationController?.setViewControllers([vc], animated: true)
        
            
        }))
        
        present(alert, animated: true)
        
    }
}

