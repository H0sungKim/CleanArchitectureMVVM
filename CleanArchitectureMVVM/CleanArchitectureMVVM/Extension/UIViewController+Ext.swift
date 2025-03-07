//
//  UIViewController+Ext.swift
//  CleanArchitectureMVVM
//
//  Created by Hosung.Kim on 2021/11/22.
//

import UIKit

extension UIViewController {
    class func initialize<T: UIViewController>() -> T {
        let identifier: String = String(describing: T.self)
        let sb = UIStoryboard(name: identifier, bundle: Bundle.presentationLayer)
        let vc = sb.instantiateViewController(withIdentifier: identifier) as! T
        return vc
    }
}
