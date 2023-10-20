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
    
    init(offer: OfferDetailModel) {
        id = offer.id
        name = offer.name
        shortDescription = offer.shortDescription
        description = offer.description
    }
    
    init() {
        id = ""
        name = ""
        shortDescription = ""
        description = ""
    }
}

protocol OfferDetailViewModelType {
    var itemViewModel: Observable<OfferDetailItemViewModel>! { get }
    var showAlert: PublishSubject<Bool> { get }
//    var offerId: String? { get set }
    
//    func getOfferDetail()
}

class OfferDetailViewModel: OfferDetailViewModelType {
    
    
    var itemViewModel: Observable<OfferDetailItemViewModel>!
    var showAlert: PublishSubject<Bool> = PublishSubject()
    
//    var offerId: String?
    let disposeBag = DisposeBag()
    var interactor: OfferInteractorType
    
    init(interactor: OfferInteractorType) {
        self.interactor = interactor
        
        self.itemViewModel = interactor.getOfferDetails().map {
            OfferDetailItemViewModel(offer: $0)
        }
        .catch { error in
            self.showAlert.onNext(true)
            return Observable.just(OfferDetailItemViewModel())
        }
        
//        self.showAlert = interactor.getOfferDetails().asObservable()
//            .map { _ in false }
//            .catchAndReturn(true)
    }
    
    
//    func getOfferDetail() {
//        interactor.getOfferDetails().subscribe { event in
//            switch event {
//            case .success(let data):
//                self.itemViewModel.accept(OfferDetailItemViewModel(offer: data))
//            case .failure(let error):
//                print("Error: \(error.localizedDescription )")
//                self.showAlert.accept(true)
//            }
//        }.disposed(by: disposeBag)
//
//    }
}
