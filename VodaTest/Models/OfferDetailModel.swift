//
//  OfferDetailModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation

class OfferDetailModel: Codable {

    var id: String = ""
    var name: String? = ""
    var shortDescription: String? = ""
    var description: String? = ""
    
    init(id: String, name: String?, shortDescription: String?, description: String?) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.description = description
    }
}
