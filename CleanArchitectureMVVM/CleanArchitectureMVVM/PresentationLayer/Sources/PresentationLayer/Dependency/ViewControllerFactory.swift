//
//  ViewControllerFactory.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.04.
//

import Foundation
import UIKit

public protocol ViewControllerFactory {
    func makeMainViewController(catViewModel: CatViewModel?) -> MainViewController
    func makeCatDetailViewController(index: Int, catViewModel: CatViewModel?) -> CatDetailViewController
}
