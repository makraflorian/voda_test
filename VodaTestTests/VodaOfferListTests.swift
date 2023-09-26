//
//  VodaOfferListTests.swift
//  VodaTestTests
//
//  Created by Makra Flórián Róbert on 2023. 09. 04..
//

import XCTest
import Moya
@testable import VodaTest

final class VodaOfferListTests: XCTestCase {
    
    var offersViewModel: OffersViewModel!
    let networkManager: NetworkManager = NetworkManager(provider: MoyaProvider<MyService>(stubClosure: MoyaProvider.immediatelyStub))

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        offersViewModel = OffersViewModel(networkManager: networkManager)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offersViewModel = nil
        try super.tearDownWithError()
    }
    
    func testOffersLoad() throws {
        offersViewModel.getOffers()
        let offers = offersViewModel.offers
        XCTAssertFalse(offers.isEmpty, "offers array is empty")
    }
    
    func testOfferGroups() throws {
        offersViewModel.getOffers()
        let offerGroups = offersViewModel.offersGroups
        XCTAssertFalse(offerGroups.value.count < 2, "not enough offer groups")
    }

}
