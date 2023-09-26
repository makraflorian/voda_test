//
//  OffersViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation
import Moya

class OffersViewModel {
    
    var offersGroups: Box<[OfferTypeModel]> = Box([])
    var showAlert: Box<Bool> = Box(false)
    var networkManager: NetworkManager
    
    var offers: [OfferModel] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getOffers() {
        networkManager.getOffers { result in
            switch result {
            case .success(let data):
                self.offers = data.filter { $0.id != nil && $0.rank != nil }
                
                var temp: [OfferTypeModel] = []
                
                var normal = self.offers.filter { !$0.isSpecial! }
                var special = self.offers.filter { $0.isSpecial! }
                if !special.isEmpty {
                    special = special.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Special Offers", offers: special))
                }
                if !normal.isEmpty {
                    normal = normal.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Offers", offers: normal))
                }
                
                self.offersGroups.value = temp
                
            case .failure(let error):
                print("Error: \(error.localizedDescription )")
                self.showAlert.value = true
                
            }
        }
    }
}
