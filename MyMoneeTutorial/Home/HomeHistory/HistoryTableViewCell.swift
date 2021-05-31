//
//  HistoryTableViewCell.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageStatus.layer.cornerRadius = 10
        mainView.layer.cornerRadius = 10
    }
    
    func showData(data: Transaction) {
        lblName.text = data.labelName
        lblPrice.text = data.labelPrice
        lblDate.text = data.labelDate
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }    

    
}
