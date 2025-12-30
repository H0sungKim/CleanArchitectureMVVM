//
//  CatUseCase.swift
//  Domain
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

import Entity
import Repository

public protocol CatUseCase {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error>
}

public final class DefaultCatUseCase: CatUseCase {
    private let catRepository: CatRepository
    
    public init(catRepository: CatRepository) {
        self.catRepository = catRepository
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return catRepository.fetchCats(count: count)
    }
}

public final class MockCatUseCase: CatUseCase {
    
    public init() {
        
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return Just(
            [CatEntity(imageUrl: URL(string: "https://lv2-cdn.azureedge.net/jypark/f8ba911ed379439fbe831212be8701f9-231103%206PM%20%EB%B0%95%EC%A7%84%EC%98%81%20Conceptphoto03(Clean).jpg"), size: .zero, species: "냐옹", features: "박진냥이에용~", wikipedia: URL(string: "https://en.wikipedia.org/wiki/J.Y._Park"))]
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
