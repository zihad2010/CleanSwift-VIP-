//
//  URLRequest+Json.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/14/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static  func jsonRequest(url: String,parameter: [String:Any]? = nil,methodType: Method,accessToken:String? = nil) -> URLRequest {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "\(methodType)"
        if let  parameter = parameter  {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let  accessToken = accessToken  {
            request.setValue(accessToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return request
    }
}
