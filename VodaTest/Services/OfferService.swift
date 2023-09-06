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
        switch self {
        case .getOffers:
            return "[{\"id\":\"1\",\"name\":\"One time 1 GB\",\"rank\":2,\"isSpecial\":false,\"shortDescription\":\"Let\'s choose between our data packages. This is a special offer just for you!\"},{\"id\":\"2\",\"name\":\"One time 300 MB\",\"rank\":1,\"isSpecial\":true,\"shortDescription\":\"Let\'s choose between our data packages.\"},{\"id\":\"3\",\"name\":\"One time 500 MB\",\"rank\":4,\"isSpecial\":true,\"shortDescription\":\"Let\'s choose between our data packages.\"},{\"id\":\"4\",\"name\":\"One time 100 MB\",\"rank\":3,\"isSpecial\":true,\"shortDescription\":\"\"}]".utf8Encoded
        case .getOfferDetails(_):
            return "{\"id\":\"1\",\"name\":\"One time 1 GB\",\"description\":\"1GB 30 day once off prepaid data bundle. This option is ideal if you don’t exceed your bundle often and want to take advantage of the lower in-bundle rates. You can buy as many once-off bundles as you wish.\",\"shortDescription\":\"Let\'s choose between our data packages.\"}".utf8Encoded
        }
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
