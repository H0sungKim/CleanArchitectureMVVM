//
//  AppFlowCoordinator.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func makeMainViewController(catViewModel: CatViewModel?) -> UIViewController
}

class AppDIProvider: ViewControllerFactory {
    
    static let shared = AppDIProvider()
    
    private init() {
        self.catDIProvider = DefaultCatDIProvider()
    }
    
    private init(catDIProvider: CatDIProvider) {
        self.catDIProvider = catDIProvider
    }
    
    private let catDIProvider: CatDIProvider
    
    func makeMainViewController(catViewModel: CatViewModel? = nil) -> UIViewController {
        let viewController = UIViewController.getViewController(viewControllerEnum: .main)
        if let mainViewController = viewController as? MainViewController {
            let catViewModel: CatViewModel = catViewModel ?? catDIProvider.makeCatViewModel()
            mainViewController.inject(catViewModel: catViewModel)
        }
        return viewController
    }
}
