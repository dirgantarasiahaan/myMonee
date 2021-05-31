//
//  EditHistoryViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class EditHistoryViewController: UIViewController {

    @IBOutlet weak var btnOutcome: UIButton!
    @IBOutlet weak var btnIncome: UIButton!
    @IBOutlet weak var txtJumlah: UITextField!
    @IBOutlet weak var txtJudul: UITextField!
    
    var id: Int! = nil
    var judul: String! = ""
    var jumlah: String! = ""
    var status: Bool! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtJudul.text = judul
        txtJumlah.text = jumlah
        
        if status {
            btnOutcome.layer.borderWidth = 5
            btnOutcome.layer.borderColor = UIColor.systemBlue.cgColor
            btnOutcome.layer.cornerRadius = 15
        } else {
            btnIncome.layer.borderWidth = 5
            btnIncome.layer.borderColor = UIColor.systemBlue.cgColor
            btnIncome.layer.cornerRadius = 15
        }
    }

    @IBAction func btnPerbarui(_ sender: Any) {
        
        func handleUpdateData(){
            print("creating ")
            NetworkService.shared.updateData(id: String(self.id + 1), labelName: txtJudul.text ?? "", labelPrice: txtJumlah.text ?? "", labelDate: DateFormatter().dateNow(), status: status!) { (err) in
                print("failed \(err)")
                return
            }
                print("Finish")
            }
        handleUpdateData()

        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(pengeluaranPemasukan), forKey: "arrayHome2")
        navigationController?.setViewControllers([vc], animated: true)
    
    }
    
    @IBAction func btnPemasukan(_ sender: Any) {
           btnIncome.layer.borderWidth = 5
           btnIncome.layer.borderColor = UIColor.systemBlue.cgColor
           status = false
           btnIncome.layer.cornerRadius = 15
           btnOutcome.layer.borderWidth = 0
           btnOutcome.layer.borderColor = UIColor.white.cgColor
           
       }
       
       @IBAction func btnPengeluaran(_ sender: Any) {
           btnOutcome.layer.borderWidth = 5
           btnOutcome.layer.borderColor = UIColor.systemBlue.cgColor
           btnOutcome.layer.cornerRadius = 15
           status = true
           btnIncome.layer.borderWidth = 0
           btnIncome.layer.borderColor = UIColor.white.cgColor
       }
    

    @IBAction func btnHapus(_ sender: Any) {
        let alert = UIAlertController(title: "Menghapus Riwayat Penggunaan", message: "Apakah anda yakin ingin mengahapus ''\(judul!)''?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {action in
//            pengeluaranPemasukan.remove(at: Indexes().get(id: self.id))
            
            NetworkService.shared.deleteById(id: self.id+1) { (err) in
                if let err = err {
                    print("failed \(err)")
                    return
                }
                print("success")
            }
            
            print("tapped delete")
            
            let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
//            UserDefaults.standard.set(try? PropertyListEncoder().encode(pengeluaranPemasukan), forKey: "arrayHome2")
    
            self.navigationController?.setViewControllers([vc], animated: true)
            
        }))
        
        present(alert, animated: true)
    }

}


class Indexes {
    func get(id: Int) -> Int {
        var indexPath: Int! = nil
        var i: Int! = 0
        for item in pengeluaranPemasukan {
            if item.id! == id+1 {
                indexPath = i
            }
            i += 1
        }
        return indexPath!
    }
}
