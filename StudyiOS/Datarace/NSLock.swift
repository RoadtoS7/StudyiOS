//
//  NSLock.swift
//  StudyiOS
//
//  Created by nylah.j on 5/21/24.
//

import Foundation
// 기존에는 lock을 사용했다.
// Task를 사용하면 mutable한 변수를 캡쳐할 수 없도록 한다.

class Counter {
    let lock: NSLock = .init()
    var count: Int = .zero // data race 발생 가능 (mutable)
    
    func increment() {
        lock.lock()
        defer {
            lock.unlock()
        }
        count += 1
        
    }
    
    
    static func test() {
        let workCount = 1000
        let counter = Counter()
        
        for _ in 0..<workCount {
            Task {
                counter.increment
            }
        }
        
        Thread.sleep(forTimeInterval: 2.0)
        print("$$ countr.count: ", counter.count) // Outputs: 1000
    }
    
    /// 컴파일러는 더이상 mutable한 변수를 다른 실행 context 에서 캡쳐하는 것을 허용하지 않는다.
    func doSometing() {
        var count = 0
        Task {
//            print(count) // compile error 발생!!
        }
    }
    
    /// mutable한 변수도 명시하면 immutable하게 캡쳐하면 캡쳐가 가능하다.
    func canCaptureExplicit() {
        var count = 0
        Task { [count] in
            print(count)
        }
    }
    
    /// escaping closure 는 mutable 한 변수를 캡쳐하는 것이 허용되는데, 이때 compiler의 warning 이 없어서 race condition이 발생할 수 있다.
    func doSomting2() {
        var count = 0
        let workCount = 1000
        
        for _ in 0..<workCount {
            Thread.detachNewThread { // escaping 하고 sendable한 closure
                count += 1
            }
        }
        Thread.sleep(forTimeInterval: 2)
        print("count", count) // Outputs a value less than 1000, e.g., 978
    }
}
