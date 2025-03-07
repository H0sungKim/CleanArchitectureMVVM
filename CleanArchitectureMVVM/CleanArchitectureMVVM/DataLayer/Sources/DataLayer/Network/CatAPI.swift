//
//  CatAPI.swift
//  DataLayer
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Moya

enum CatAPI {
    case fetchCats(count: Int)
}

extension CatAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com")!
    }
    
    var path: String {
        switch self {
        case .fetchCats:
            return "/v1/images/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCats:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchCats(let count):
            return .requestParameters(parameters: [
                "limit": count,
                "has_breeds": 1,
                "api_key": Bundle.module.apiKey ?? ""
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
