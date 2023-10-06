//
//  OfferInteractor.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 10. 04..
//

import Foundation
import RxSwift
import RxCocoa

protocol OfferInteractorType {
    
    func getOffers() -> Single<[OfferTypeModel]>
    func getOfferDetails() -> Single<OfferDetailModel>
}

class OfferInteractor: OfferInteractorType {
    var networkManager: NetworkManagerType
    let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func getOffers() -> Single<[OfferTypeModel]> {
        networkManager.handleRequests(api: .getOffers)
            .map([OfferModel].self)
            .map { offerArray in
                let offers = offerArray.filter { $0.id != nil && $0.rank != nil }
                
                var temp: [OfferTypeModel] = []
                
                var normal = offers.filter { !$0.isSpecial! }
                var special = offers.filter { $0.isSpecial! }
                if !special.isEmpty {
                    special = special.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Special Offers", offers: special))
                }
                if !normal.isEmpty {
                    normal = normal.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Offers", offers: normal))
                }
                return temp
            }
    }
    
    func getOfferDetails() -> Single<OfferDetailModel> {
        networkManager.handleRequests(api: .getOfferDetails(id: ""))
            .map(OfferDetailModel.self)
            .map { offer in
                return offer
            }
    }
}
