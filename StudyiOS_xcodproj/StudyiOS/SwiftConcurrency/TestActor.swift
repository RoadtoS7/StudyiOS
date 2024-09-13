//
//  Actor.swift
//  StudyiOS
//
//  Created by 김수현 on 8/28/24.
//

import Foundation
import UIKit

actor Counter {
    var count: Int // count를 동시에 동작하는 task에서 접근하면 race condition이 발생할 수 있다.
    
    init(count: Int) {
        self.count = count
    }
    
    init() {
        self.count = 0
    }
    
    func increment() {
        count += 1
    }
}

final class ViewModel {
    let counter: Counter = .init()
    
    func increment() {
        
    }
    
}

final class ActorSampleViewController: UIViewController {
    
}



