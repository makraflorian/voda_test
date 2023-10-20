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
    
    func getOffers() -> Observable<[OfferTypeModel]>
    func getOfferDetails() -> Observable<OfferDetailModel>
}

class OfferInteractor: OfferInteractorType {
    var networkManager: NetworkManagerType
    let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func getOffers() -> Observable<[OfferTypeModel]> {
        networkManager.handleRequests(api: .getOffers)
            .map([OfferModel].self)
            .map { offerArray in
                let offers = offerArray.filter { $0.id != nil && $0.rank != nil }
                
                var temp: [OfferTypeModel] = []
                
                var normal = offers.filter { !$0.isSpecial! }
                var special = offers.filter { $0.isSpecial! }
                if !special.isEmpty {
                    special = special.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Special Offers", items: special))
                }
                if !normal.isEmpty {
                    normal = normal.sorted { $0.rank! < $1.rank! }
                    temp.append(OfferTypeModel(name: "Offers", items: normal))
                }
                return temp
            }.asObservable()
    }
    
    func getOfferDetails() -> Observable<OfferDetailModel> {
        networkManager.handleRequests(api: .getOfferDetails(id: ""))
            .map(OfferDetailModel.self)
            .map { offer in
                return offer
            }.asObservable()
    }
}
