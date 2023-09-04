//
//  OfferService.swift
//  VodaTest
//
//  Created by Makra Flórián Róbert on 2023. 08. 31..
//

import Foundation
import Moya

enum MyService {
    case getOffers
    case getOfferDetails(id: String)
}

// MARK: - TargetType Protocol Implementation https://api.npoint.io/c1d049e131d742ff3cf2
extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://api.npoint.io")! }
    var path: String {
        switch self {
        case .getOffers:
            return "/8539be17636e67811994/offers"
        case .getOfferDetails(_):
            return "/c1d049e131d742ff3cf2"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getOffers, .getOfferDetails:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getOffers, .getOfferDetails: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {
//        switch self {
//        case .getOffers:
//            return "Half measures are as bad as nothing at all.".utf8Encoded
//        case .getOfferDetails(let id):
//            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
//        case .createUser(let firstName, let lastName):
//            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
//        case .updateUser(let id, let firstName, let lastName):
//            return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
//        case .showAccounts:
//            // Provided you have a file named accounts.json in your bundle.
//            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
//                let data = try? Data(contentsOf: url) else {
//                    return Data()
//            }
            return Data()
//        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
