//
//  VodaOfferDetailTests.swift
//  VodaTestTests
//
//  Created by Makra Flórián Róbert on 2023. 09. 05..
//

import XCTest
import Moya
import RxBlocking
@testable import VodaTest

final class VodaOfferDetailTests: XCTestCase {

    var offerDetailViewModel: OfferDetailViewModel!
    let networkManager: NetworkManager = NetworkManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        networkManager.setProvider(provider: MoyaProvider<OfferAPI>(stubClosure: MoyaProvider.delayedStub(3)))
        offerDetailViewModel = OfferDetailViewModel(interactor: OfferInteractor(networkManager: networkManager))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offerDetailViewModel = nil
        try super.tearDownWithError()
    }

    func testOfferDetailLoad() throws {
        offerDetailViewModel.getOfferDetail()
        let itemViewModel = offerDetailViewModel.itemViewModel
        XCTAssertFalse((try itemViewModel.skip(1).toBlocking().first()?.id == ""), "no valid offer")
//        XCTAssertFalse(((try offers.skip(1).toBlocking().first()?.isEmpty) == nil), "offersGroups array is empty")
    }

}
