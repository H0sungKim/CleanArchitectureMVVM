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
    var cats: [CatEntity] { get }
    var catsPublished: Published<[CatEntity]> { get }
    var catsPublisher: Published<[CatEntity]>.Publisher { get }
}

protocol CatViewModel: CatViewModelInput, CatViewModelOutput { }

class DefaultCatViewModel: CatViewModel {
    @Published private(set) var cats: [CatEntity] = []
    var catsPublished: Published<[CatEntity]> { _cats }
    var catsPublisher: Published<[CatEntity]>.Publisher { $cats }
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
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
