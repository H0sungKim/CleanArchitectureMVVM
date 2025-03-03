//
//  CatRepository.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Moya
import Combine

protocol CatRepository {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], MoyaError>
}
