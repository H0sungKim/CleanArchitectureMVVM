//
//  AppConfig.swift
//  CleanArchitectureMVVM
//
//  Created by 김호성 on 2025.12.20.
//

import Foundation

enum AppConfig {
    static let apiKey: String = {
        guard let file = Bundle.main.path(forResource: "Secret", ofType: "plist") else { fatalError("Secret.plist not found.") }
        guard let resource = NSDictionary(contentsOfFile: file) else { fatalError("Secret.plist not found.") }
        guard let key = resource["api_key"] as? String else { fatalError("api_key not found.") }
        return key
    }()
}
