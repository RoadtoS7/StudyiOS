//
//  AsyncAwaitOnWhichThreadViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/09/27.
//
// async-await method가 기본적으로 어디 스레드에서 호출되는지 체크하는 것

import UIKit
import OSLog


class AsyncAwaitOnWhichThreadViewController: UIViewController {
    // private 또는 fileprivate의 프로퍼티는 private으로 선언되어야 한다.
    private let structTester: StructAsyncAwait = .init()
    private let classTester: ClassAsyncAwait = .init()
    private let logger = Logger()
    
    @MainActor
    override func viewDidLoad() {
        print("$$ viewDidLoad - mainThread? ", Thread.isMainThread) // true
        super.viewDidLoad()
        Task { // main thread
            let message: String = mainThreadCheckMessage()
            print("$$ ViewController - Task - ", message) // true
            
            print("$$ StrucTester async start")

            await structTester.pretendingAsync() // MainActor가 아닌 Task에서 호출된 async-await는 어디 스레드에서 호출될지 보장되지 않는다.
            await classTester.pretendingAsync()
            
            await structTester.test() // false
            await classTester.test() // false
            
            structTester.notAsyncCall() // main
            classTester.notAsyncCall() // main
        }
        
        structTester.startTask() // false
        classTester.startTask() // false
    }
    
    
    @MainActor
    private func asyncCall(id: Int) async {
        logger.log("$$ async로 표기되더라도, MainActor에서 호출될 때는 동기로 호출됩니다. - id: \(id)")
    }
    
    private func notAsyncCall() {
        let message: String = mainThreadCheckMessage()
        print("$$ ViewController - notAsyncCall - ", message)
    }
}

func mainThreadCheckMessage() -> String {
    return Thread.current.isMainThread ? "on MainThread" : "not on MainThread"
}

private struct StructAsyncAwait {
    func test() async {
//        try? await Task.sleep(nanoseconds: 1)
        let message: String = mainThreadCheckMessage()
        print("$$ StructAsyncAwait - ", message) // main thread X
    }
    
    func pretendingAsync() async {
        let message: String = mainThreadCheckMessage()
        let result: Bool = Thread.current.isMainThread
        print("$$ 이것은 async이지만 내부에서 async-await를 사용하지 않습니다. mainThread? - ", result)
    }
    
    func startTask() {
        Task {
            let message: String = mainThreadCheckMessage()
            print("$$ StructAsyncAwait - Task - ", message)
        }
    }
    
    func notAsyncCall() {
        let message: String = mainThreadCheckMessage()
        print("$$ StructAsyncAwait - notAsyncCall - ", message)
    }
}

private class ClassAsyncAwait {
    func test() async {
        try? await Task.sleep(nanoseconds: 1)
        let message: String = mainThreadCheckMessage()
        print("$$ ClassAsyncAwait - ", message)
    }
    
    func pretendingAsync() async {
        let message: String = mainThreadCheckMessage()
        print("$$ 이것은 async이지만 내부에서 async-await를 사용하지 않습니다. mainThread? - ", message)
    }
    
    func startTask() {
        Task {
            let message: String = mainThreadCheckMessage()
            print("$$ ClassAsyncAwait - Task - ", message)
        }
    }
    
    func notAsyncCall() {
        let message: String = mainThreadCheckMessage()
        print("$$ ClassAsyncAwait - notAsyncCall - ", message)
    }
}
