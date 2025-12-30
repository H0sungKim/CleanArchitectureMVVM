//
//  DefaultCatRepository.swift
//  Data
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

import Moya

import Domain

import Networking

public final class DefaultCatRepository: CatRepository {
    
    private let catService: CatService
    
    public init(catService: CatService) {
        self.catService = catService
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return catService.fetchCats(count: count)
            .map({ $0.map(\.catEntity) })
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}
