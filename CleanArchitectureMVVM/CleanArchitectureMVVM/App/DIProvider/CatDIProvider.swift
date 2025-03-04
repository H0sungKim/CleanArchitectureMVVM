//
//  CatDIContainer.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import Foundation

protocol CatDIProvider {
    func makeCatRepository() -> CatRepository
    func makeCatRepository(catService: CatService) -> CatRepository
    
    func makeCatUseCase() -> CatUseCase
    func makeCatUseCase(catRepository: CatRepository) -> CatUseCase
    
    func makeCatViewModel() -> CatViewModel
    func makeCatViewModel(catUseCase: CatUseCase) -> CatViewModel
}

class DefaultCatDIProvider: CatDIProvider {
    func makeCatRepository() -> CatRepository {
        return DefaultCatRepository(catService: DefaultCatService())
    }
    func makeCatRepository(catService: CatService) -> CatRepository {
        return DefaultCatRepository(catService: catService)
    }
    
    func makeCatUseCase() -> CatUseCase {
        return DefaultCatUseCase(catRepository: makeCatRepository())
    }
    func makeCatUseCase(catRepository: CatRepository) -> CatUseCase {
        return DefaultCatUseCase(catRepository: catRepository)
    }
    
    func makeCatViewModel() -> CatViewModel {
        return DefaultCatViewModel(catUseCase: makeCatUseCase())
    }
    func makeCatViewModel(catUseCase: CatUseCase) -> CatViewModel {
        return DefaultCatViewModel(catUseCase: catUseCase)
    }
}
