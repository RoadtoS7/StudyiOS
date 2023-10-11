//
//  Data+Extensions.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/10.
//

import Foundation

extension Data {
    func decode<CachedValue: Decodable>() -> CachedValue? {
        let jsonDecoder = JSONDecoder()
        
        if let cachedValue = try? jsonDecoder.decode(CachedValue.self, from: self) {
            return cachedValue
        }
        return nil
    }
}
