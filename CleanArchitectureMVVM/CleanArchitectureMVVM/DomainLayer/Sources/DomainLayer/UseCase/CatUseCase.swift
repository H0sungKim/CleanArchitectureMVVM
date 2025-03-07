//
//  CatUseCase.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine
import Moya

public protocol CatUseCase {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError>
}

public class DefaultCatUseCase: CatUseCase {
    private let catRepository: CatRepository
    
    public init(catRepository: CatRepository) {
        self.catRepository = catRepository
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError> {
        return catRepository.fetchCats(count: count)
    }
}
