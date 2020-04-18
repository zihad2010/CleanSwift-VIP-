

import UIKit

struct Domain {
    static let dev = "http://vccuat.us-east-2.elasticbeanstalk.com"
    static let assest = "http://image.tmdb.org/t/p/w185/"

}
extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let API_USER_SIGNIN         = "/rest/auth/sign-in"
}


