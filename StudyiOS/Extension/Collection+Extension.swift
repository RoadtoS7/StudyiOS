//
//  Collection.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/09/14.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

