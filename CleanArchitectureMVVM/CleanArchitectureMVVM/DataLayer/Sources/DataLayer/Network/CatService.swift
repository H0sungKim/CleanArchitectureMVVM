//
//  CatService.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Moya
import Combine
import CombineMoya

public protocol CatService {
    func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError>
}

public class DefaultCatService: CatService {
    private let provider = MoyaProvider<CatAPI>()
    
    public init() { }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError> {
        return provider.requestPublisher(.fetchCats(count: count))
            .map([CatResponseDTO].self)
    }
}
