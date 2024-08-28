//
//  ViewType.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import UIKit
import SwiftUI

struct ViewType {
    let title: String
    let toViewController: UIViewController
}

#if DEBUG
extension ViewType {
    static let hostingViewController = UIHostingController(rootView: NavigationTestView())
    
    static var value = [
        ViewType(title: "Prototype of CollectionView", toViewController: CollectionViewController()),
        ViewType(title: "ImageView", toViewController: MultipleLinkTextViewController()),
        ViewType(title: "TextView with Multiple Links", toViewController: TestCombineViewController()),
        ViewType(title: "Test Future", toViewController: ResponderChainViewController()),
        ViewType(title: "Touch Event Responable View", toViewController: OverlappedViewController()),
        ViewType(title: "Alter Responder Chain", toViewController: OverlappedViewController()),
        ViewType(title: "Test Retained Publisher", toViewController: TestCombineViewController()),
        ViewType(title: "If there is no subviews, are layout callbacks called?", toViewController: NonSubviewsViewController()),
        ViewType(title: "[SwiftUI] - NavigationView", toViewController: hostingViewController),
        ViewType(title: "GCD - weak self 관계 ", toViewController: GCDViewController()),
        ViewType(title: "엣지백 제스처에서 UINavigationController의 delegate 메서드 호출 여부 체크", toViewController: EdgeBackNavigationViewController()),
        ViewType(title: "async-await 메서드의 실행 스레드가 언제 Main 스레드인가?", toViewController: AsyncAwaitOnWhichThreadViewController()),
        ViewType(title: "DispatchQueue.main.async를 대체하는 방법", toViewController: FromGCDToTaskViewController()),
        ViewType(title: "CoreData 테스트", toViewController: CoreDataViewController()),
        ViewType(title: "File System 경로 출력", toViewController: FileManagerViewController()),
        ViewType(title: "Throttle 동작 Test", toViewController: ThrottleViewController()),
        ViewType(title: "layer를 통한 circle 만들기", toViewController: TestLayerViewController()),
        
    ]
    
    static func get(ofIndex index: Int) -> ViewType? {
        value[safe: index]
    }
}
#endif
