//
//  CatDIContainer.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import Foundation

protocol CatDIContainer {
    func buildCatRepository(catService: CatService?) -> CatRepository
    func buildCatUseCase(catRepository: CatRepository?) -> CatUseCase
    func buildCatViewModel(catUseCase: CatUseCase?) -> CatViewModel
}

class CatDIContainerImpl: CatDIContainer {
    func buildCatRepository(catService: CatService? = nil) -> CatRepository {
        let catService: CatService = catService ?? CatServiceImpl()
        return CatRepositoryImpl(catService: catService)
    }
    
    func buildCatUseCase(catRepository: CatRepository? = nil) -> CatUseCase {
        let catRepository: CatRepository = catRepository ?? buildCatRepository()
        return CatUseCaseImpl(catRepository: catRepository)
    }
    
    func buildCatViewModel(catUseCase: CatUseCase? = nil) -> CatViewModel {
        let catUseCase: CatUseCase = catUseCase ?? buildCatUseCase()
        return CatViewModel(catUseCase: catUseCase)
    }
}
