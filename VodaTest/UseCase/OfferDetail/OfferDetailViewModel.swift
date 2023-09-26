//
//  OfferDetailViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import Foundation
import Moya

struct OfferDetailItemViewModel {
    
    var id: String?
    var name: String?
    var shortDescription: String?
    var description: String?
    
    init(offer: OfferDetailModel) {
        id = offer.id
        name = offer.name
        shortDescription = offer.shortDescription
        description = offer.description
    }
    
    init() {
        id = ""
        name = ""
        shortDescription = ""
        description = ""
    }
}

class OfferDetailViewModel {
    
    var itemViewModel: Box<OfferDetailItemViewModel> = Box(OfferDetailItemViewModel())
    var showAlert: Box<Bool> = Box(false)
    
    var offerId: String?
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getOfferDetail() {
        networkManager.getOfferDetails(offerId: offerId ?? "") { result in
            switch result {
            case .success(let data):
                self.itemViewModel.value = OfferDetailItemViewModel(offer: data)
                
            case .failure(let error):
                print("Error: \(error.localizedDescription )")
                self.showAlert.value = true
                
            }
        }
    }
}
