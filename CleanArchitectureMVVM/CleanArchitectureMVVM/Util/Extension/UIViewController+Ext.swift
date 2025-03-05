//
//  UIViewController+Ext.swift
//  DuckStar
//
//  Created by Hosung.Kim on 2021/11/22.
//

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
        return getViewController(storyboard: viewControllerEnum.storyboard, identifier: String(describing: viewControllerEnum.viewController), modalPresentationStyle: .fullScreen)
    }
    
    private class func getViewController(storyboard: String, identifier: String, modalPresentationStyle: UIModalPresentationStyle) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = modalPresentationStyle
        return vc
    }
}
