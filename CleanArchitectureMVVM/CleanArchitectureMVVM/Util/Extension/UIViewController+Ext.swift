//
//  UIViewController+Ext.swift
//  DuckStar
//
//  Created by Hosung.Kim on 2021/11/22.
//

import PresentationLayer

import UIKit

enum ViewControllerEnum: String, CaseIterable {
    case main
    case catDetail
    
    var storyboard: String {
        switch self {
        case .main:
            return "Main"
        case .catDetail:
            return "CatDetail"
        }
    }
    
    var viewController: UIViewController.Type {
        switch self {
        case .main:
            return MainViewController.self
        case .catDetail:
            return CatDetailViewController.self
        }
    }
}

extension UIViewController {
    class func getViewController(viewControllerEnum: ViewControllerEnum) -> UIViewController {
        return getViewController(storyboard: viewControllerEnum.storyboard, identifier: String(describing: viewControllerEnum.viewController))
    }
    
    private class func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: Bundle.presentationLayer)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        return vc
    }
}
