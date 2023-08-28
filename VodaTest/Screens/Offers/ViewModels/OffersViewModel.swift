//
//  OffersViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation
///nsobj?
class OffersViewModel: NSObject {
    
    var offers: [OfferModel] = []{
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    func getOffers() {
        // TODO
        offers = [OfferModel(id: "1", isSpecial: false, name: "ASD", shortDescription: "asdasdasd"), OfferModel(id: "2", isSpecial: false, name: "ASD2", shortDescription: "asdasdasd")]
    }
}
