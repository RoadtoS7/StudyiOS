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
        ViewType(title: "Touch Event Responable View"),
        ViewType(title: "Alter Responder Chain"),
        ViewType(title: "Test Retained Publisher"),
        ViewType(title: "If there is no subviews, are layout callbacks called?"),
        ViewType(title: "[SwiftUI] - NavigationView"),
        ViewType(title: "GCD - weak self 관계 "),
        ViewType(title: "엣지백 제스처에서 UINavigationController의 delegate 메서드 호출 여부 체크"),
        ViewType(title: "async-await 메서드의 실행 스레드가 언제 Main 스레드인가?"),
        ViewType(title: "CoreData 테스트")
    ]
}
#endif
