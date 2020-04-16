

import UIKit

struct Domain {
    static let dev = "http://"
    static let assest = "http://image.tmdb.org/t/p/w185/"

}
extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let API_USER_SIGNIN         = ""
}


