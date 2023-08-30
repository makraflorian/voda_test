//
//  OfferDetailViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import Foundation

class OfferDetailViewModel: NSObject {
    
    var offer: OfferDetailModel?
    
    var offerId: String?
    
    func getOfferDetail() {
        // TODO
//        if let offer = offerDetail as? OfferDetailModel {
//
//        }
//        call service with the given id to fetch data
        offer = OfferDetailModel(id: "1", name: "10 TB offer pog", shortDescription: "Best offer", description: "Literally the best")
    }
}
