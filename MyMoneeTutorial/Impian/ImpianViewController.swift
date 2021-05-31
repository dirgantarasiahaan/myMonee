//
//  ImpianViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

protocol TambahImpianProtocol {
    func tambahImpian()
}

class ImpianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImpianTableViewProtocol, ImpianTercapaiProtocol, TambahImpianProtocol {
    func tambahImpian() {
        navigationController?.pushViewController(AddImpianViewController(), animated: true)
    }
    
    @IBOutlet weak var btnBuatImpian: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var impianTableView: UITableView!
    var impians: [Impian] = []
    
    var btnDelete: ImpianTableViewProtocol?
    var test = EditImpianViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Impian"
        print("impian : \(impian)")
        
        
        if let savedData = UserDefaults.standard.value(forKey: "arrayImpian") as? Data {
            let _impian = try? PropertyListDecoder().decode(Array<Impian>.self, from: savedData)
                    impian = _impian ?? []
                }
        impians = impian.sorted(by: { $0.id! > $1.id! })
        
        impianTableView.delegate = self
        impianTableView.dataSource = self
        let uiNIb = UINib(nibName: String(describing: ImpianTableViewCell.self), bundle: nil)
        impianTableView.register(uiNIb, forCellReuseIdentifier: String(describing: ImpianTableViewCell.self))
    }
    
    @IBAction func didTapButton(){
//        navigationController?.pushViewController(AddImpianViewController(), animated: true)
        tambahImpian()
    }
    
    func deleteData(indexes: Int) {
        impian.remove(at: indexes)
        impianTableView.reloadData()
        UserDefaults.standard.set(try? PropertyListEncoder().encode(impian), forKey: "arrayImpian")
        viewDidLoad()
    }
    
    func impianTercapai() {
        let alertController = UIAlertController(title: "SELAMAT!", message: "Impian mu tercapai", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok!", style: .default) { _ in
        }
        alertController.addAction(saveAction)
        print("test")

        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            tableView.deselectRow(at: indexPath, animated: true)

            let dream = impian[indexPath.row]
            let vc = DetilImpianViewController(nibName: "DetilImpianViewController", bundle: nil)
            vc.id = dream.id! - 1
            vc.name = dream.lblName
            vc.price = dream.lblPrice
            vc.targetPrice = dream.priceTarget
            vc.progress = dream.progress
            print(dream.id!)
            navigationController?.pushViewController(vc, animated: true)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if impian.count == 0 {
                      impianTableView.setEmptyMessage("Data kamu kosong,\nYuk mulai buat impian kamu!")
                    btnBuatImpian.isHidden = false
                    } else {
                        btnBuatImpian.isHidden = true
                        impianTableView.restore()
                    }
                return impian.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = impianTableView.dequeueReusableCell(withIdentifier: String(describing: ImpianTableViewCell.self), for: indexPath) as! ImpianTableViewCell
        cell.delegate = self
        cell.delegateTercapai = self
                       cell.lblName.text = impian[indexPath.row].lblName
               cell.lblPrice.text = "IDR \(NumberFormatter().format(amount: Int(impian[indexPath.row].lblPrice!) ?? 0)) / IDR \(NumberFormatter().format(amount: Int(impian[indexPath.row].priceTarget!) ?? 0))"
                       cell.progress.setProgress(impian[indexPath.row].progress ?? 0.0, animated: true)
       
               self.impianTableView.rowHeight = 65
        cell.index = indexPath.row
        if impian[indexPath.row].progress == 1.0 {
            cell.btnVerified.setImage(UIImage(named: "ceklis"), for: UIControl.State.normal)
        } else {
            cell.btnVerified.setImage(UIImage(named: "ceklis non"), for: UIControl.State.normal)
            cell.btnVerified.isEnabled = false
        }
        return cell
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}
