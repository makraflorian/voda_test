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
    let stubbingProvider = MoyaProvider<MyService>(stubClosure: MoyaProvider.immediatelyStub)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        offerDetailViewModel = OfferDetailViewModel(moyaProvider: stubbingProvider)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offerDetailViewModel = nil
        try super.tearDownWithError()
    }

    func testOfferDetailLoad() throws {
        offerDetailViewModel.getOfferDetail()
        let offerId = offerDetailViewModel.id
        XCTAssertFalse(offerId.value.isEmpty, "no valid offer")
    }

}
