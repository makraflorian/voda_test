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
    
    func getOffers(refreshRelay: RefreshRelay) -> NetworkResult<[OfferModel]>
    func getOfferDetails(refreshRelay: RefreshRelay) -> NetworkResult<OfferDetailModel>
}

class OfferInteractor: OfferInteractorType {
    var networkManager: NetworkManagerType
    let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func getOffers(refreshRelay: RefreshRelay) -> NetworkResult<[OfferModel]> {
        let result = networkManager.handleRequests(api: .getOffers).map([OfferModel].self).map {
            Result<[OfferModel], Error>.success($0)
        }.asObservable()
            .catch { error in
                Observable.just(Result<[OfferModel], Error>.failure(error))
            }
        
        return NetworkResult(result: result, refreshRelay: refreshRelay)
    }
    
    func getOfferDetails(refreshRelay: RefreshRelay) -> NetworkResult<OfferDetailModel> {
        let result = networkManager.handleRequests(api: .getOfferDetails(id: "")).map(OfferDetailModel.self).map {
            Result<OfferDetailModel, Error>.success($0)
        }.asObservable()
            .catch { error in
                Observable.just(Result<OfferDetailModel, Error>.failure(error))
            }
        
        return NetworkResult(result: result, refreshRelay: refreshRelay)
    }
}
