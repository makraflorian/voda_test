//
//  RefreshRelay.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 10. 24..
//

import Foundation
import RxSwift

class RefreshRelay: ObservableType {
    private let subject: PublishSubject<Bool>

    public func refresh(_ blocking: Bool) {
        subject.onNext(blocking)
    }

    public init() {
        subject = PublishSubject()
    }

    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable
        where Observer.Element == Bool {
        return subject.subscribe(observer)
    }

    public func asObservable() -> Observable<Bool> {
        return subject.asObservable()
    }
}
