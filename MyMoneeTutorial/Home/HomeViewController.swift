//
//  HomeViewController.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 11/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var btnTambahPenggunaan: UIButton!
    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var viewSaldo: UIView!
    @IBOutlet weak var viewPengeluaran: UIView!
    @IBOutlet weak var viewPemasukan: UIView!
    @IBOutlet weak var txtSalam: UILabel!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var sisaSaldo: UILabel!
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var outcome: UILabel!
    @IBOutlet weak var viewTableRiwayat: UIView!
    
    var transactionList: [Transaction] = [].sorted { DateFormatter().date(from: $0.labelDate!)! < DateFormatter().date(from: $1.labelDate!)! } {
        didSet {
            historyTableView.reloadData()
        }
    }
    
    var service: NetworkService = NetworkService()
    
    var passName: String? = ""
    var pemasukan: Int? = 0
    var pengeluaran: Int? = 0
    var saldo: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.loadData()
        title = "Beranda"
            
        print("list : \(transactionList)")
        
        viewTableRiwayat.layer.cornerRadius = 25
        viewSaldo.layer.cornerRadius = 15
        viewPemasukan.layer.cornerRadius = 10
        viewPengeluaran.layer.cornerRadius = 10
        
        txtSalam.text = Salam()
        let tabBar = tabBarController as! MainTabController
        txtName.text = String(describing: tabBar.username!)

        historyTableView.delegate = self
        historyTableView.dataSource = self
    
        let uiNIb = UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil)
        historyTableView.register(uiNIb, forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
        historyTableView.reloadData()
  
    }
    
    func countPriceByStatus(status : Bool) -> Int {
        var priceTotal : Int = 0
        for item in transactionList {
            if(item.status == status){
                let price = Int(item.labelPrice!)
                priceTotal += price!
            }
            
        }
        return priceTotal
        
    }
    
    func loadData() {
        service.loadTransactionList { transaction in
            DispatchQueue.main.async {
                self.transactionList = transaction
                let incomes = self.countPriceByStatus(status: false)
                let outcomes = self.countPriceByStatus(status: true)
                self.income.text = "Rp \(NumberFormatter().format(amount: incomes))"
                self.outcome.text = "Rp \(NumberFormatter().format(amount: outcomes))"
                self.saldo = incomes - outcomes
                self.sisaSaldo.text = "Rp \(NumberFormatter().format(amount: self.saldo ?? 0))"
                print("list2 : \(self.transactionList)")
            }
        }
        print("transaction lahh")
    }

    @objc fileprivate func handleCreatePost(){
        print("creating ")
        NetworkService.shared.createPost(id: "10", labelName: "test", labelPrice: "2000", labelDate: "12-12-2021 12:12:12", status: true) { (err) in
            if let err = err {
                print("failed \(err)")
                return
            }
            print("Finish")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabController
        txtName.text = String(describing: tabBar.username!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    @IBAction func didTapButton(){
        navigationController?.pushViewController(AddHistoryViewController(), animated: true)
    }
    
    @IBAction func btnTambahPenggunaa(_ sender: Any) {
        let vc = AddHistoryViewController(nibName: "AddHistoryViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func Salam() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        var greeting: String! = ""
        let waktu: Int! = Int(formatter.string(from: currentDateTime))
        if waktu >= 0 && waktu <= 9{
            greeting = "Selamat Pagi,"
        } else if waktu >= 10 && waktu <= 14 {
            greeting = "Selamat Siang,"
        } else if waktu >= 15 && waktu <= 18 {
            greeting = "Selamat Sore,"
        } else if waktu >= 19 && waktu <= 23 {
            greeting = "Selamat Malam,"
        }
        return greeting
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            tableView.deselectRow(at: indexPath, animated: true)
            let ex = transactionList[indexPath.row]
            let vc = PreviewHistoryViewController(nibName: "PreviewHistoryViewController", bundle: nil)
            vc.id = Int(ex.id!)! - 1
            vc.name = ex.labelName
            vc.DateParam = ex.labelDate
            vc.priceParam = ex.labelPrice
            vc.status = ex.status
            navigationController?.pushViewController(vc, animated: true)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if transactionList.count == 0 {
                      historyTableView.setEmptyMessage("Data kamu kosong, \nYuk mulai buat catatan kamu")
                    btnTambahPenggunaan.isHidden = false
                    } else {
                        historyTableView.restore()
                        btnTambahPenggunaan.isHidden = true
                    }
        return transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self), for: indexPath) as! HistoryTableViewCell

                       cell.lblName.text = transactionList[indexPath.row].labelName
                       cell.lblDate.text = transactionList[indexPath.row].labelDate
                if transactionList[indexPath.row].status! {
                           cell.imageStatus.image = UIImage(named: "outcome icon")
                           cell.lblPrice.textColor = UIColor.red
                    cell.lblPrice.text = "-Rp \(NumberFormatter().format(amount: Int(transactionList[indexPath.row].labelPrice!) ?? 0))"

                       } else {
                           cell.imageStatus.image = UIImage(named: "income icon")
                           cell.lblPrice.textColor = UIColor.systemGreen
                        cell.lblPrice.text = "+Rp \(NumberFormatter().format(amount: Int(transactionList[indexPath.row].labelPrice!) ?? 0))"
                       }
                return cell
    }
}

