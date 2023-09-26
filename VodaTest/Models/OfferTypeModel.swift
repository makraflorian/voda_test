//
//  OfferTypeModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 21..
//

import Foundation

class OfferTypeModel: Codable {
    var name: String
    var offers: [OfferModel] = []
    
    init(name: String, offers: [OfferModel]?) {
        self.name = name
        self.offers = offers ?? []
    }
}
