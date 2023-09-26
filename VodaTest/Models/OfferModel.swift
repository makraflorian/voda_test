//
//  OfferModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation

class OfferModel: Codable {

    var id: String?
    var rank: Int?
    var isSpecial: Bool?
    var name: String?
    var shortDescription: String?
    
    init(id: String?, rank: Int?, isSpecial: Bool?, name: String?, shortDescription: String?) {
        self.id = id
        self.rank = rank
        self.isSpecial = isSpecial
        self.name = name
        self.shortDescription = shortDescription
    }
}
