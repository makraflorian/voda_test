//
//  OfferDetailViewModel.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 29..
//

import Foundation
import Moya

class OfferDetailViewModel: NSObject {
    
    private var offer: OfferDetailModel? {
        didSet {
            id.value = offer?.id ?? ""
            name.value = offer?.name ?? ""
            shortDescription.value = offer?.shortDescription ?? ""
            longDescription.value = offer?.description ?? ""
        }
    }
    
    var id: Box<String> = Box("")
    var name: Box<String> = Box("")
    var shortDescription: Box<String> = Box("")
    var longDescription: Box<String> = Box("")
    
    var showAlert: Box<Bool> = Box(false)
    
    var offerId: String?
    
    var provider: MoyaProvider<MyService>
    
    init(moyaProvider: MoyaProvider<MyService> = MoyaProvider<MyService>()) {
        self.provider = moyaProvider
    }
    
    func getOfferDetail() {
        
        provider.request(.getOfferDetails(id: offerId ?? "")) { result in
            switch result {
            case let .success(moyaResponse):
                do {
//                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    print(data)
                    self.offer = try moyaResponse.map(OfferDetailModel.self)

                }
                catch {
                    self.showAlert.value = true
                    print(error.localizedDescription)
                }

                // do something in your app
            case let .failure(error):
                print("Error: \(error.errorDescription ?? "Unknown error")")
                self.showAlert.value = true
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}
