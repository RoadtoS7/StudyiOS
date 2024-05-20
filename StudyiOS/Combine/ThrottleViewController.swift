//
//  ThrottleViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 11/16/23.
//
// Rx의 throttle과 다르게 동작한다
// 시간 간격당 한 개의 ouput을 emit한다.
// 출력 최대화!

// https://forums.swift.org/t/surprising-semantics-of-throttled-sequences/65409/7
// throttle 구현 방식: https://gist.github.com/JCSooHwanCho/a35a824c216a658930a4004d424c6cba\
// 동작방식: https://github.com/apple/swift-async-algorithms/issues/266

import UIKit
import Combine

class ThrottleViewController: UIViewController {
    var cancellable: AnyCancellable?
    var cancellables: Set<AnyCancellable> = .init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        testPassthroughSubject()
    }
    
    func testTimer() {
        /**
         2023-11-16 02:14:55 +0000: request unlimited
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:14:58 +0000)
         Received Timestamp 2023-11-16 02:14:58 +0000. // 가장 첫번째꺼 무조건 발행
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:01 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:04 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:07 +0000) ✅
         Received Timestamp 2023-11-16 02:15:07 +0000. // 10초 동안 가장 최신 것 발행
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:10 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:13 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:16 +0000) ✅
         Received Timestamp 2023-11-16 02:15:16 +0000. // 10초 동안 가장 최신 것 발행
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:19 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:22 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:25 +0000)
         2023-11-16 02:14:55 +0000: receive value: (2023-11-16 02:15:28 +0000) ✅
         Received Timestamp 2023-11-16 02:15:28 +0000. // 10초 동안 가장 최신 것 발행
         */
        
        cancellable = Timer.publish(every: 3.0, on: .main, in: .default)
            .autoconnect()
            .print("\(Date().description)")
            .throttle(for: 10.0, scheduler: RunLoop.main, latest: true)
            .sink(
                receiveCompletion: { print ("Completion: \($0).") },
                receiveValue: { print("Received Timestamp \($0).") }
             )
    }
    
    func testPassthroughSubject() {
        /**
         A 2023-11-16 02:23:42 +0000
         D 2023-11-16 02:23:45 +0000 ✅ D도 같이 출력된다.
         D가 전송되고 이후 3초 동안 다른 이벤트가 전송되지 않았기 때문에, 그 이후 3초동안 가장 첫번째 데이터는 D가 된다. 따라서 D가 출력된다.
         */
        let subject: PassthroughSubject<String, Never> = .init()
        
        let throttled = subject.throttle(for: .seconds(3), scheduler: RunLoop.main, latest: false)
        throttled.sink {
            print($0, Date())
        }.store(in: &cancellables)
        
        subject.send("A")
        subject.send("B")
        subject.send("C")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: .init {
            subject.send("D")
        })
    }
    
//    func test_trailing_delay_without_latest() throws {
//        guard #available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *) else { throw XCTSkip("Skipped due to Clock/Instant/Duration availability") }
//        validate {
//            "abcdefghijkl|"
//            $0.inputs[0]._throttle(for: .steps(3), clock: $0.clock, latest: false)
//            "a--b--e--h--[k|]"
//        }
//    }
    
    deinit {
        cancellable?.cancel()
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        cancellable = nil
    }
}
