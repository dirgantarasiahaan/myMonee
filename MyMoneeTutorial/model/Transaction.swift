//
//  Transaction.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 20/05/21.
//

import Foundation

struct TransationResponse: Codable {
    var results: [Transaction]?
}

struct Transaction: Codable {
    var id: String?
    var labelName: String?
    var labelPrice: String?
    var labelDate: String?
    var status: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case labelName
        case labelPrice
        case labelDate
        case status 
    }
}
