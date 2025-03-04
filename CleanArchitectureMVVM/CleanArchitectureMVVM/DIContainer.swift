//
//  AppFlowCoordinator.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.03.04.
//

import Foundation
import UIKit

class DIContainer: CatDIContainerImpl {
    
    static let shared = DIContainer()
    private override init() { }
    
    func buildMainViewController(catViewModel: CatViewModel? = nil) -> UIViewController {
        let viewController = UIViewController.getViewController(viewControllerEnum: .main)
        if let mainViewController = viewController as? MainViewController {
            let catViewModel: CatViewModel = catViewModel ?? buildCatViewModel()
            mainViewController.inject(catViewModel: catViewModel)
        }
        return viewController
    }
}
