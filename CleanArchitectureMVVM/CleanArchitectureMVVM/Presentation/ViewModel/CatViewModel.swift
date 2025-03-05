//
//  CatViewModel.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

protocol CatViewModelInput {
    func addCat(count: Int)
    func deleteCat(index: Int)
}

protocol CatViewModelOutput {
    var cats: CurrentValueSubject<[CatEntity], Never> { get }
}

protocol CatViewModel: CatViewModelInput, CatViewModelOutput { }

class DefaultCatViewModel: CatViewModel {
    var cats: CurrentValueSubject<[CatEntity], Never> = .init([])
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let catUseCase: CatUseCase
    
    init(catUseCase: CatUseCase) {
        self.catUseCase = catUseCase
    }
    
    func addCat(count: Int) {
        catUseCase.fetchCats(count: count)
            .manageThread()
            .sinkHandledCompletion(receiveValue: { [weak self] catEntities in
                self?.cats.value.append(contentsOf: catEntities)
            })
            .store(in: &cancellable)
    }
    
    func deleteCat(index: Int) {
        cats.value.remove(at: index)
    }
}
