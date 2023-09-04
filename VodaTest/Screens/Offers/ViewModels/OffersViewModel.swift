//
//  OffersViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation
import Moya

///nsobj?
class OffersViewModel: NSObject {
    
    var offers: [OfferModel] = []

    var offersGroups: Box<[OfferTypeModel]> = Box([])
    
    var provider: MoyaProvider<MyService>!
    
    func getOffers() {

        let provider = MoyaProvider<MyService>()
        provider.request(.getOffers) { result in
            switch result {
            case let .success(moyaResponse):
                do {
//                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    print(data)
                    self.offers = try moyaResponse.map([OfferModel].self)
                    self.offers = self.offers.filter { $0.rank != nil }

                    var temp: [OfferTypeModel] = []
                    
                    var normal = self.offers.filter { !$0.isSpecial! }
                    var special = self.offers.filter { $0.isSpecial! }
                    if !special.isEmpty {
                        special = special.sorted { $0.rank! > $1.rank! }
                        temp.append(OfferTypeModel(name: "Special", offers: special))
                    }
                    if !normal.isEmpty {
                        normal = normal.sorted { $0.rank! > $1.rank! }
                        temp.append(OfferTypeModel(name: "Normal", offers: normal))
                    }

                    self.offersGroups.value = temp

                }
                catch {
                    // show an error to your user
                }

                // do something in your app
            case let .failure(error):
                print("Shit \(error.errorDescription ?? "Shit")")
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}
