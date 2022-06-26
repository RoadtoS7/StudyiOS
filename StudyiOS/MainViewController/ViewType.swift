//
//  ViewType.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import Foundation

struct ViewType {
    let title: String
}

#if DEBUG
extension ViewType {
    static var value = [
        ViewType(title: "Prototype of CollectionView")
    ]
}
#endif
