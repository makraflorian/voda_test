//
//  VodaOfferListTests.swift
//  VodaTestTests
//
//  Created by Makra Flórián Róbert on 2023. 09. 04..
//

import XCTest
import Moya
import RxBlocking
@testable import VodaTest

final class VodaOfferListTests: XCTestCase {
    
    var offersViewModel: OffersViewModel!
    let networkManager: NetworkManager = NetworkManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        networkManager.setProvider(provider: MoyaProvider<OfferAPI>(stubClosure: MoyaProvider.delayedStub(3)))
        offersViewModel = OffersViewModel(interactor: OfferInteractor(networkManager: networkManager))
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        offersViewModel = nil
        try super.tearDownWithError()
    }
    
    func testOffersLoad() throws {
        offersViewModel.getOffers()
        let offers = offersViewModel.offersGroups
        XCTAssertFalse(((try offers.skip(1).toBlocking().first()?.isEmpty) == nil), "offersGroups array is empty")
    }
    
    func testOfferGroups() throws {
        offersViewModel.getOffers()
        let offerGroups = offersViewModel.offersGroups
        XCTAssertEqual(try offerGroups.skip(1).toBlocking().first()?.count, 2)
    }

}
