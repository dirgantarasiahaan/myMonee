//
//  ImpianTableViewCell.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

protocol ImpianTableViewProtocol {
    func deleteData(indexes: Int)
}

protocol ImpianTercapaiProtocol {
    func impianTercapai()
}

//protocol  {
//    requirements
//}

class ImpianTableViewCell: UITableViewCell {

    @IBOutlet weak var btnHapus: UIButton!
    @IBOutlet weak var btnVerified: UIButton!
    @IBOutlet weak var ImpianView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    var delegate: ImpianTableViewProtocol?
    var delegateTercapai: ImpianTercapaiProtocol?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImpianView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    @IBAction func btnVerified(_ sender: Any) {
        delegateTercapai?.impianTercapai()
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        delegate?.deleteData(indexes: index ?? 0)
    }
}
