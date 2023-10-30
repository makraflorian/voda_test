//
//  NetworkResult.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 10. 24..
//

import Foundation
import RxSwift

class NetworkResult<T>: ObservableType where T: Codable {
    let originalRequest: Observable<Result<T, Error>>
    let networkResult: Observable<Result<T, Error>>
    
    let refreshRelay: RefreshRelay
    
    public init(result: Observable<Result<T, Error>>, refreshRelay: RefreshRelay) {
        self.refreshRelay = refreshRelay
        
        originalRequest = result
        networkResult = self.refreshRelay
            .flatMapLatest { _ -> Observable<Result<T, Error>> in
                let apiCall = result
                return apiCall
            }
    }
    
    public func subscribe<Observer>(_ observer: Observer) -> Disposable where
        Observer: ObserverType, Result<T, Error> == Observer.Element {
            return networkResult.subscribe(observer)
            
        }
    
    public typealias Element = Result<T, Error>
    
    public func refresh(_ blocking: Bool) {
        refreshRelay.refresh(blocking)
    }
}
