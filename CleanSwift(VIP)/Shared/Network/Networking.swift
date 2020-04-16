//
//  Networking.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/14/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation
import UIKit

enum Result<data,error> {
    case networkFinishedWithData(data,error)
    case networkFinishedWithError(error)
}

typealias Handler = (Result<Data,Error>) -> Void

enum NetworkError: Error{
    case nullData
    case data
    case offline
    case invalidURL
    case undefined
}


public enum Method {
    case delete
    case get
    case head
    case post
    case put
    case connect
    case options
    case trace
    case patch
    case other(method: String)
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "DELETE":
            self = .delete
        case "GET":
            self = .get
        case "HEAD":
            self = .head
        case "POST":
            self = .post
        case "PUT":
            self = .put
        case "CONNECT":
            self = .connect
        case "OPTIONS":
            self = .options
        case "TRACE":
            self = .trace
        case "PATCH":
            self = .patch
        default:
            self = .other(method: method)
        }
    }
}

extension Method: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .delete:            return "DELETE"
        case .get:               return "GET"
        case .head:              return "HEAD"
        case .post:              return "POST"
        case .put:               return "PUT"
        case .connect:           return "CONNECT"
        case .options:           return "OPTIONS"
        case .trace:             return "TRACE"
        case .patch:             return "PATCH"
        case .other(let method): return method.uppercased()
        }
    }
}

enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}



//MARK: - Network Client

class NetworkClient {
    
    static let shared = NetworkClient()
    
    func sendRequest( methodType: Method, url: String, parameter: [NSString: Any]? = nil, accessToken: String? = nil, completion: @escaping (Handler)) {
        
        let request = URLRequest.jsonRequest(url: url,parameter: parameter as [String : Any]?,methodType: methodType, accessToken:accessToken)
        
        guard let _ = request.url else {
             completion(.networkFinishedWithError(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.session().dataTask(with: request as URLRequest,  completionHandler: { (data, response, error) in
            
            if let networkError = error {
                if let nsError = networkError as NSError? {
                    switch nsError.code {
                    case -1009:
                        completion(.networkFinishedWithError(NetworkError.offline))
                        break
                    default:
                        print("nsError & message:",nsError.code,networkError.localizedDescription)
                        completion(.networkFinishedWithError(NetworkError.undefined))
                        break
                    }
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...499).contains(httpResponse.statusCode),let data = data else {
                    if let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode >= 500 {
                        //print(httpResponse.statusCode)
                        // let error: NSError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Sever Error"])
                        completion(.networkFinishedWithError(HTTPStatusCodes.init(rawValue: httpResponse.statusCode)!))
                    }
                    return
            }
            print("Server Status:",HTTPStatusCodes.init(rawValue: httpResponse.statusCode)!,httpResponse.statusCode )
            completion(.networkFinishedWithData(data,HTTPStatusCodes.init(rawValue: httpResponse.statusCode)! ))
        })
        task.resume()
    }
}

//extension HTTPURLResponse {
//
//      var status: HTTPStatusCode? {
//          return HTTPStatusCode(rawValue: statusCode)
//      }
//}


