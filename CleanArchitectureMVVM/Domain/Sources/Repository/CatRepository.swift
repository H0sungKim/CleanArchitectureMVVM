//
//  CatRepository.swift
//  Domain
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

import Entity

public protocol CatRepository {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error>
}
