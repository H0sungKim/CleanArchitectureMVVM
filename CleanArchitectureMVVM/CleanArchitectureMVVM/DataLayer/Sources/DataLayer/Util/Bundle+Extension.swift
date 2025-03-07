// Copyright © 2025 HealEat. All rights reserved.

import Foundation

extension Bundle {
    
    var apiKey: String? {
        guard let file = self.path(forResource: "Secret", ofType: "plist") else { return nil }
        guard let resource = NSDictionary(contentsOfFile: file) else { return nil }
        
        guard let key = resource["api_key"] as? String else { return nil }
        return key
    }
}
