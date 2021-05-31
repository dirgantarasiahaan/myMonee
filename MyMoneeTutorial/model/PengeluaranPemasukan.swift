//
//  PengeluaranPemasukan.swift
//  MyMoneeTutorial
//
//  Created by MacBook on 13/05/21.
//

import Foundation

struct PengeluaranPemasukan: Codable {
    var id: Int?
    var labelName: String?
    var labelPrice: String?
    var labelDate: String? 
    var status: Bool = false
}


var pengeluaranPemasukan: [PengeluaranPemasukan] = []

