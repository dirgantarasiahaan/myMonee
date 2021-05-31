//
//  DetilImpianViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class DetilImpianViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var btnTercapai: UIButton!
    @IBOutlet weak var viewProgresBar: UIView!
    @IBOutlet weak var btnHapus: UIButton!
    @IBOutlet weak var lblImpian: UILabel!
    
    var id: Int! = nil
    var name: String! = ""
    var price: String! = ""
    var progress: Float! = 0.0
    var targetPrice: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewProgresBar.layer.cornerRadius = 10
        viewProgresBar.layer.borderWidth = 4.0
        viewProgresBar.layer.borderColor = UIColor.systemGray6.cgColor
        
        lblName.text = name
        lblPrice.text = "Rp \(NumberFormatter().format(amount: Int(targetPrice!) ?? 0))"
        lblImpian.text = "Impian"
        percentage.text = String(format: "%.2f", progress*100) + "%"
        progressBar.setProgress(progress, animated: true)
        lblTotal.text = "IDR \(NumberFormatter().format(amount: Int(price!) ?? 0)) / IDR \(NumberFormatter().format(amount: Int(targetPrice!) ?? 0))"
        
        if progress == 1 {
            btnTercapai.isEnabled = true
        } else {
            btnTercapai.isEnabled = false
        }
    }
    
    
    @IBAction func didTapButtonEdit(){
        let vc = EditImpianViewController(nibName: "EditImpianViewController", bundle: nil)
        vc.id = id
        vc.judul = name
        vc.target = targetPrice
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnKembali(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func confirmAchieve(_ sender: Any) {
        let alertController = UIAlertController(title: "SELAMAT!", message: "Impian mu tercapai", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok!", style: .default) { _ in
            impian.remove(at: IndexImpian().get(id: self.id))
            let vc = ImpianViewController(nibName: "ImpianViewController", bundle: nil)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(impian), forKey: "arrayImpian")
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    
    }
}

class IndexImpian {
    func get(id: Int) -> Int {
        var indexPath: Int! = nil
        var i: Int! = 0
        for item in impian {
            if item.id! == id+1 {
                indexPath = i
            }
            i += 1
        }
        return indexPath
    }
}
