//
//  URLSession+Session.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/14/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation

extension URLSession{
   static func session() -> URLSession{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        return URLSession(configuration: sessionConfig)
    }
}
