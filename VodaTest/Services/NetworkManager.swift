//
//  NetworkManager.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 09. 25..
//

import Foundation
import Moya

class NetworkManager {
    
    var provider: MoyaProvider<MyService>
    
    init(provider: MoyaProvider<MyService> = MoyaProvider<MyService>()) {
        self.provider = provider
    }
    
    func getOffers(completion: @escaping (Result<[OfferModel], Error>)->()) {
        provider.request(.getOffers) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.map([OfferModel].self)
                    print(data)
                    completion(.success(data))
                }
                catch {
                    // show an error to your user
                    completion(.failure(error))
                }
                
            case let .failure(error):
                print("Error: \(error.errorDescription ?? "Unknown error")")
                completion(.failure(error))
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
    
    func getOfferDetails(offerId: String, completion: @escaping (Result<OfferDetailModel, Error>)->()) {
        provider.request(.getOfferDetails(id: offerId)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.map(OfferDetailModel.self)
                    print(data)
                    completion(.success(data))
                }
                catch {
                    // show an error to your user
                    completion(.failure(error))
                }
                
            case let .failure(error):
                print("Error: \(error.errorDescription ?? "Unknown error")")
                completion(.failure(error))
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
    
}
