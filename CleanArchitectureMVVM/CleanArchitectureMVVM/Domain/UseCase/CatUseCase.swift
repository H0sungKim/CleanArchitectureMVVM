//
//  CatUseCase.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine
import Moya

protocol CatUseCase {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError>
}

class DefaultCatUseCase: CatUseCase {
    let catRepository: CatRepository
    
    init(catRepository: CatRepository) {
        self.catRepository = catRepository
    }
    
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError> {
        return catRepository.fetchCats(count: count)
    }
}
