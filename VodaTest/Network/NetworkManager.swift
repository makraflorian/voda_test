//
//  NetworkManager.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 25..
//

import Foundation
import RxSwift
import Moya

protocol NetworkManagerType {
    
    func handleRequests(api: OfferAPI) -> Single<Response>
    func setProvider(provider: MoyaProvider<OfferAPI>)
}

class NetworkManager: NetworkManagerType {
    
    var provider: MoyaProvider<OfferAPI>
    
    init() {
        self.provider = MoyaProvider<OfferAPI>()
    }
    
    func setProvider(provider: MoyaProvider<OfferAPI>) {
        self.provider = provider
    }

    func handleRequests(api: OfferAPI) -> Single<Response> {
        return provider.rx.request(api)
            .filterSuccessfulStatusAndRedirectCodes()
    }
}
