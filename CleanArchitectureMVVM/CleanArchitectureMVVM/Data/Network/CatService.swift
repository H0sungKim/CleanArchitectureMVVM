//
//  CatService.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol CatService {
    func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError>
}

class CatServiceImpl: CatService {
    private let provider = MoyaProvider<CatAPI>()
    
    func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError> {
        return provider.requestPublisher(.fetchCats(count: count))
            .map([CatResponseDTO].self)
    }
}
