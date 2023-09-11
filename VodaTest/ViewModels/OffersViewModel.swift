//
//  OffersViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation
import Moya

class OffersViewModel {
    
    var offers: [OfferModel] = []
    
    var offersGroups: Box<[OfferTypeModel]> = Box([])
    
    var showAlert: Box<Bool> = Box(false)
    
    var provider: MoyaProvider<MyService>
    
    init(moyaProvider: MoyaProvider<MyService> = MoyaProvider<MyService>()) {
        self.provider = moyaProvider
    }
    
    func getOffers() {
        self.provider.request(.getOffers) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapJSON()
                    print(data)
                    self.offers = try moyaResponse.map([OfferModel].self)
                    self.offers = self.offers.filter { $0.id != nil && $0.rank != nil }
                    
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
                    
                }
                catch {
                    // show an error to your user
                    self.showAlert.value = true
                }
                
            case let .failure(error):
                print("Error: \(error.errorDescription ?? "Unknown error")")
                self.showAlert.value = true
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}
