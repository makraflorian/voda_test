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
    var offersGroups: BehaviorRelay<[OfferTypeModel]> { get }
    var showAlert: BehaviorRelay<Bool> { get }
    
    func getOffers()
    
}

class OffersViewModel: OffersViewModelType {
    
    var offersGroups: BehaviorRelay<[OfferTypeModel]> = BehaviorRelay<[OfferTypeModel]>(value: [])
    var showAlert: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    var interactor: OfferInteractorType
    
    init(interactor: OfferInteractorType) {
        self.interactor = interactor
    }
    
    func getOffers() {
        
        interactor.getOffers().subscribe { event in
            switch event {
            case .success(let data):
                self.offersGroups.accept(data)
            case .failure(let error):
                print("Error: \(error.localizedDescription )")
                self.showAlert.accept(true)
            }
        }.disposed(by: disposeBag)
    }
}
