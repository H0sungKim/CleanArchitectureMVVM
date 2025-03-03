//
//  CatRepositoryImpl.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine
import Moya

class CatRepositoryImpl: CatRepository {
    
    private let catService: CatService
    
    init(catService: CatService) {
        self.catService = catService
    }
    
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError> {
        return catService.fetchCats(count: count)
            .map({ $0.map(\.entity) })
            .eraseToAnyPublisher()
    }
}
