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
    var offersGroups: Observable<[OfferTypeModel]>! { get }
    var showAlert: PublishSubject<Bool> { get }
    
//    func getOffers()
    
}

class OffersViewModel: OffersViewModelType {
    
    var offersGroups: Observable<[OfferTypeModel]>!
    var showAlert: PublishSubject<Bool> = PublishSubject()
    
    let disposeBag = DisposeBag()
    var interactor: OfferInteractorType
    
    init(interactor: OfferInteractorType) {
        self.interactor = interactor
        
        self.offersGroups = interactor.getOffers()
            .catch { error in
                self.showAlert.onNext(true)
                return Observable.just([])
            }
        
//        self.showAlert = interactor.getOffers()
//            .map { _ in false }
//            .catchAndReturn(true)
    }
    
//    func getOffers() {
//
//        interactor.getOffers().subscribe { event in
//            switch event {
//            case .success(let data):
//                self.offersGroups.accept(data)
//            case .failure(let error):
//                print("Error: \(error.localizedDescription )")
//                self.showAlert.accept(true)
//            }
//        }.disposed(by: disposeBag)
//    }
}
