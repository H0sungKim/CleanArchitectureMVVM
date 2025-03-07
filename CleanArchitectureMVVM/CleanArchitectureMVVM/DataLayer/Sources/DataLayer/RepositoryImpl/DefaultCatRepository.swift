//
//  DefaultCatRepository.swift
//  DataLayer
//
//  Created by 김호성 on 2025.03.03.
//

import DomainLayer

import Foundation
import Combine
import Moya

public class DefaultCatRepository: CatRepository {
    
    private let catService: CatService
    
    public init(catService: CatService) {
        self.catService = catService
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError> {
        return catService.fetchCats(count: count)
            .map({ $0.map(\.entity) })
            .eraseToAnyPublisher()
    }
}
