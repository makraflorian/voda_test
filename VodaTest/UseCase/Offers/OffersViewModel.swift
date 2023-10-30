//
//  OffersViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 25..
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol OffersViewModelType {
    var offersGroups: Observable<[OfferTypeModel]> { get }
    var showAlert: PublishSubject<Bool> { get }
    var screenRefreshRelays: [RefreshRelay] { get }
    var refreshRelay: RefreshRelay { get }
}

class OffersViewModel: OffersViewModelType {
    
    var offersGroups: Observable<[OfferTypeModel]>
    var showAlert: PublishSubject<Bool> = PublishSubject()
    var screenRefreshRelays: [RefreshRelay]
    let disposeBag = DisposeBag()
    var interactor: OfferInteractorType
    var refreshRelay: RefreshRelay
    
    init(interactor: OfferInteractorType) {
        self.interactor = interactor
        self.refreshRelay = RefreshRelay()
        screenRefreshRelays = [refreshRelay]
        self.offersGroups = interactor.getOffers(refreshRelay: refreshRelay)
            .map { offerResult in
                switch offerResult {
                case .success(let offerArray):
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
                case .failure:
                    return [OfferTypeModel(withError: true)]
                }
                
            }.asObservable()
    }
}
