//
//  VodaOfferDetailTests.swift
//  VodaTestTests
//
//  Created by Makra Flórián Róbert on 2023. 09. 05..
//

import XCTest
import Moya
@testable import VodaTest

final class VodaOfferDetailTests: XCTestCase {

    var offerDetailViewModel: OfferDetailViewModel!
    let networkManager: NetworkManager = NetworkManager(provider: MoyaProvider<OfferAPI>(stubClosure: MoyaProvider.immediatelyStub))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        offerDetailViewModel = OfferDetailViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offerDetailViewModel = nil
        try super.tearDownWithError()
    }

    func testOfferDetailLoad() throws {
        offerDetailViewModel.getOfferDetail()
        let offerId = offerDetailViewModel.itemViewModel.value.id
        XCTAssertFalse(offerId!.isEmpty, "no valid offer")
    }

}
