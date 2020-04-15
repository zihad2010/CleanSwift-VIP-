//
//  JSONDecoder+Decode.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/14/20.
//  Copyright © 2020 Steve JobsOne. All rights reserved.
//

import Foundation


enum DecodeResult<data, errorStr> {
    case success(data)
    case failure(errorStr)
}

typealias DecodeHandler = (DecodeResult<Codable,String>) -> Void

extension JSONDecoder{
    static func decodeData<Model: Codable>(model: Model.Type,_ data:Data,completion: @escaping(DecodeHandler)){
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(Model.self, from: data)
            completion(.success(data))
        } catch {
            completion(.failure(error.localizedDescription))
        }
    }
}
