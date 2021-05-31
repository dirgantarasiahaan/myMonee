//
//  ListImpian.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 13/05/21.
//

import Foundation

struct Impian: Codable {
    
    var id: Int?
    var lblName: String?
    var lblPrice: String?
    var priceTarget: String?
    var progress: Float?    
}

var impian: [Impian] = [].sorted(by: { $0.id! > $1.id! })
