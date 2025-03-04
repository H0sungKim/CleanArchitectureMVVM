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

protocol CatViewModelOutput: ObservableObject {
    var cats: [CatEntity] { get }
}

class CatViewModel: CatViewModelInput, CatViewModelOutput {
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published private(set) var cats: [CatEntity] = []
    private let catUseCase: CatUseCase
    
    init(catUseCase: CatUseCase) {
        self.catUseCase = catUseCase
    }
    
    func addCat(count: Int) {
        catUseCase.fetchCats(count: count)
            .manageThread()
            .sinkHandledCompletion(receiveValue: { [weak self] catEntities in
                self?.cats.append(contentsOf: catEntities)
            })
            .store(in: &cancellable)
    }
    
    func deleteCat(index: Int) {
        cats.remove(at: index)
    }
}
