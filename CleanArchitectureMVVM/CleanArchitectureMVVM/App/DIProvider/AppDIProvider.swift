//
//  AppDIProvider.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import PresentationLayer

import Foundation
import UIKit

class AppDIProvider: ViewControllerFactory {
    
    init() {
        self.catDIProvider = DefaultCatDIProvider()
    }
    
    init(catDIProvider: CatDIProvider) {
        self.catDIProvider = catDIProvider
    }
    
    private let catDIProvider: CatDIProvider
    
    func makeMainViewController(catViewModel: CatViewModel? = nil) -> MainViewController {
        let viewController: MainViewController = MainViewController.initialize()
        viewController.inject(catViewModel: catViewModel ?? catDIProvider.makeCatViewModel())
        return viewController
    }
    
    func makeCatDetailViewController(index: Int, catViewModel: CatViewModel? = nil) -> CatDetailViewController {
        let viewController: CatDetailViewController = CatDetailViewController.initialize()
        viewController.inject(index: index, catViewModel: catViewModel ?? catDIProvider.makeCatViewModel())
        return viewController
    }
    
}
