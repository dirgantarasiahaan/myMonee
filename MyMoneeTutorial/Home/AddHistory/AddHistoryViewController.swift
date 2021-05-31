//
//  AddHistoryViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class AddHistoryViewController: UIViewController {


    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnIncome: UIButton!
    @IBOutlet weak var txtJudul: UITextField!
    @IBOutlet weak var txtJumlah: UITextField!
    @IBOutlet weak var btnOutcome: UIButton!
    
    var statusPick: Bool! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if txtJudul.text! == "" && txtJumlah.text! == "" {
            btnSave.isEnabled = false
        }
    }

    @IBAction func btnPemasukan(_ sender: Any) {
        btnIncome.layer.borderWidth = 3
        btnIncome.layer.cornerRadius = 15
        btnIncome.layer.borderColor = UIColor.systemBlue.cgColor
        statusPick = false
        if statusPick != false {
            btnSave.isEnabled = false
        } else {
            btnSave.isEnabled = true
        }
        btnOutcome.layer.borderWidth = 0
        btnOutcome.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func btnPengeluaran(_ sender: Any) {
        btnOutcome.layer.borderWidth = 3
        btnOutcome.layer.borderColor = UIColor.systemBlue.cgColor
        btnOutcome.layer.cornerRadius = 15
        statusPick = true
        if statusPick != true {
            btnSave.isEnabled = false
        } else {
            btnSave.isEnabled = true
        }
        print(statusPick!)
        btnIncome.layer.borderWidth = 0
        btnIncome.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func didTapButtonSimpan(){
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)        
        func handleCreatePost(){
            print("creating ")
            NetworkService.shared.createPost(id: "10", labelName: txtJudul.text ?? "", labelPrice: txtJumlah.text ?? "", labelDate: DateFormatter().dateNow(), status: statusPick) { (err) in
                if let err = err {
                    print("failed \(err)")
                    return
                }
                print("Finish")
            }
        }
        handleCreatePost()
        navigationController?.setViewControllers([vc], animated: true)
    }

}
