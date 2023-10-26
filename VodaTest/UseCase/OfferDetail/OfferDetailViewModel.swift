//
//  OfferDetailViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import Foundation
import Moya
import RxSwift
import RxCocoa

struct OfferDetailItemViewModel {
    
    var id: String?
    var name: String?
    var shortDescription: String?
    var description: String?
    var errorState: Bool?
    
    init(offer: OfferDetailModel) {
        id = offer.id
        name = offer.name
        shortDescription = offer.shortDescription
        description = offer.description
        errorState = false
    }
    
    init(hasError: Bool) {
        id = ""
        name = ""
        shortDescription = ""
        description = ""
        errorState = hasError
    }
    
    init() {
        id = ""
        name = ""
        shortDescription = ""
        description = ""
        errorState = false
    }
}

protocol OfferDetailViewModelType {
    var itemViewModel: Observable<OfferDetailItemViewModel>! { get }
    var refreshRelay: RefreshRelay { get }
}

class OfferDetailViewModel: OfferDetailViewModelType {
    
    var itemViewModel: Observable<OfferDetailItemViewModel>!
    var refreshRelay: RefreshRelay
    let disposeBag = DisposeBag()
    var interactor: OfferInteractorType
    
    init(interactor: OfferInteractorType) {
        self.interactor = interactor
        self.refreshRelay = RefreshRelay()
        self.itemViewModel = interactor.getOfferDetails(refreshRelay: refreshRelay).map { offerDetailResult in
            switch offerDetailResult {
            case .success(let offer):
                return OfferDetailItemViewModel(offer: offer)
            case .failure:
                return OfferDetailItemViewModel(hasError: true)
            }
        }.asObservable()
    }
}
