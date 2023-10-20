//
//  OfferTypeModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 21..
//

import Foundation
import RxDataSources

struct OfferTypeModel: Codable {
    var name: String
    var items: [OfferModel] = []
    
    init(name: String, items: [OfferModel]?) {
        self.name = name
        self.items = items ?? []
    }
}

extension OfferTypeModel: SectionModelType {
  typealias Item = OfferModel

   init(original: OfferTypeModel, items: [Item]) {
    self = original
    self.items = items
  }
}
