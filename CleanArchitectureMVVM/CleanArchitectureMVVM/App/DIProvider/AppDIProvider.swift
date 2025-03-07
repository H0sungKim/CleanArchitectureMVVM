//
//  AppFlowCoordinator.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import PresentationLayer

import Foundation
import UIKit

protocol ViewControllerFactory {
    func makeMainViewController(catViewModel: CatViewModel?) -> UIViewController
    func makeCatDetailViewController(index: Int, catViewModel: CatViewModel?) -> UIViewController
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
            mainViewController.inject(catViewModel: catViewModel ?? catDIProvider.makeCatViewModel())
        }
        return viewController
    }
    
    func makeCatDetailViewController(index: Int, catViewModel: CatViewModel? = nil) -> UIViewController {
        let viewController = UIViewController.getViewController(viewControllerEnum: .catDetail)
        if let catDetailViewController = viewController as? CatDetailViewController {
            catDetailViewController.inject(index: index, catViewModel: catViewModel ?? catDIProvider.makeCatViewModel())
        }
        return viewController
    }
    
}
