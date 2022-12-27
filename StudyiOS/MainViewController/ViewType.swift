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
        ViewType(title: "Prototype of CollectionView"),
        ViewType(title: "ImageView"),
        ViewType(title: "TextView with Multiple Links"),
        ViewType(title: "Test Future"),
        ViewType(title: "Touch Event Responable View")
    ]
}
#endif
