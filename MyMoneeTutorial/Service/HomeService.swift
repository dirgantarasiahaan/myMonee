//
//  HomeService.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 15/05/21.
//

import Foundation

enum money {
    case income
    case outcome
}

protocol CountResult {
    func calculateWallet(type: money) -> Int
}


class CountIncomeOutcome: CountResult {
    let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
    
    var incomeOutcomes: [Transaction]
    
    init(incomeOutcomes: [Transaction]) {
        self.incomeOutcomes = incomeOutcomes
    }
    
    func calculateWallet(type: money) -> Int {
        var total: Int! = 0
        for incomeOutcome in incomeOutcomes {
            
            switch type {
            case .outcome:
                if incomeOutcome.status! {
                    let price = (incomeOutcome.labelPrice! as NSString).integerValue
                    total += price
                }
            case .income:
                if incomeOutcome.status! == false {
                    let price = (incomeOutcome.labelPrice! as NSString).integerValue
                    total += price
                }
            }
            
        }
        return total
    }
}

extension NumberFormatter {
    func format(amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        let formattedTipAmount = formatter.string(from: amount as NSNumber)
        return formattedTipAmount ?? ""
    }
}

extension DateFormatter {
    func dateNow() ->  String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: currentDateTime)
    }
}
