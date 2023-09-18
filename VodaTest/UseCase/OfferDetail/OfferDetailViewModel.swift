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
    var provider: MoyaProvider<MyService>
    
    init(moyaProvider: MoyaProvider<MyService> = MoyaProvider<MyService>()) {
        self.provider = moyaProvider
    }
    
    func getOfferDetail() {
        
        provider.request(.getOfferDetails(id: offerId ?? "")) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapJSON()
                    print(data)
                    let offerTemp = try moyaResponse.map(OfferDetailModel.self)
                    self.itemViewModel.value = OfferDetailItemViewModel(offer: offerTemp)
                    
                }
                catch {
                    self.showAlert.value = true
                    print(error.localizedDescription)
                }
                
            case let .failure(error):
                print("Error: \(error.errorDescription ?? "Unknown error")")
                self.showAlert.value = true
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}
