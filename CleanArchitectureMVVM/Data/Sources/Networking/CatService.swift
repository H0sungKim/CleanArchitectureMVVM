//
//  CatService.swift
//  Data
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

import Moya
import CombineMoya

import DTO

public protocol CatService {
    func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError>
}

public final class DefaultCatService: CatService {
    private let provider = MoyaProvider<CatAPI>()
    private let apiKey: String?
    
    public init(apiKey: String? = nil) {
        self.apiKey = apiKey
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError> {
        return provider.requestPublisher(.fetchCats(count: count, apiKey: apiKey))
            .map([CatResponseDTO].self)
    }
}
