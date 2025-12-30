//
//  ViewControllerFactory.swift
//  Presentation
//
//  Created by 김호성 on 2025.04.27.
//

import UIKit

import ViewModel

public protocol ViewControllerFactory {
    func buildMainViewController(catViewModel: CatViewModel?) -> MainViewController
    func buildCatDetailViewController(index: Int, catViewModel: CatViewModel?) -> CatDetailViewController
}
