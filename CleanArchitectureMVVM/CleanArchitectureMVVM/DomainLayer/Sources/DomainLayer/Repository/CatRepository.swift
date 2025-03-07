//
//  CatRepository.swift
//  DomainLayer
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Moya
import Combine

public protocol CatRepository {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError>
}
