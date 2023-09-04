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
    
    var offerId: String?
    
    var provider: MoyaProvider<MyService>!
    
    func getOfferDetail() {
        
        let provider = MoyaProvider<MyService>()
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
                    print(error.localizedDescription)
                }

                // do something in your app
            case let .failure(error):
                print("Shit \(error.errorDescription ?? "Shit")")
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}
