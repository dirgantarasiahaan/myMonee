//
//  PreviewHistoryViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class PreviewHistoryViewController: UIViewController {
    
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTanggal: UILabel!
    @IBOutlet weak var idPembuatan: UILabel!
    
    var id: Int! = nil
    var name: String! = nil
    var DateParam: String! = nil
    var priceParam: String! = nil
    var status: Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        lblTanggal.text = DateParam
        idPembuatan.text = String(id+1)
        
        if status {
            imageStatus.image = UIImage(named: "Preview Pengeluaran")
            lblPrice.text = "-Rp \(NumberFormatter().format(amount: Int(priceParam!) ?? 0))"
            lblPrice.textColor = UIColor.red
            lblType.text = "Pengeluaran"

        } else {
            imageStatus.image = UIImage(named: "Preview Pemasukan")
            lblPrice.text = "+Rp \(NumberFormatter().format(amount: Int(priceParam!) ?? 0))"
            lblPrice.textColor = UIColor.systemGreen
            lblType.text = "Pemasukan"
        }
        
    }

    @IBAction func didTapButtonEdit(){
        let vc = EditHistoryViewController(nibName: "EditHistoryViewController", bundle: nil)
        vc.id = id
        vc.judul = name
        vc.jumlah = priceParam
        vc.status = status
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnKembali(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
