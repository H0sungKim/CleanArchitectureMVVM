//
//  CatViewModel.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import Combine

import Domain

public protocol CatViewModelInput {
    func addCat(count: Int)
    func deleteCat(index: Int)
}

public protocol CatViewModelOutput {
    var cats: CurrentValueSubject<[CatEntity], Never> { get }
}

public protocol CatViewModel: CatViewModelInput, CatViewModelOutput { }

public class DefaultCatViewModel: CatViewModel {
    public var cats: CurrentValueSubject<[CatEntity], Never> = .init([])
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let catUseCase: CatUseCase
    
    public init(catUseCase: CatUseCase) {
        self.catUseCase = catUseCase
    }
    
    public func addCat(count: Int) {
        catUseCase.fetchCats(count: count)
            .manageThread()
            .sinkHandledCompletion(receiveValue: { [weak self] catEntities in
                self?.cats.value.append(contentsOf: catEntities)
            })
            .store(in: &cancellable)
    }
    
    public func deleteCat(index: Int) {
        cats.value.remove(at: index)
    }
}
