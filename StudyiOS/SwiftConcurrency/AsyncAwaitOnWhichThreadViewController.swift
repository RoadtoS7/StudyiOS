//
//  AsyncAwaitOnWhichThreadViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/09/27.
//
// async-await method가 기본적으로 어디 스레드에서 호출되는지 체크하는 것

import UIKit

class AsyncAwaitOnWhichThreadViewController: UIViewController {
    // private 또는 fileprivate의 프로퍼티는 private으로 선언되어야 한다.
    private let structTester: StructAsyncAwait = .init()
    private let classTester: ClassAsyncAwait = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let message: String = mainThreadCheckMessage()
            print("$$ ViewController - Task - ", message)
            
            await structTester.test()
            await classTester.test()
            
            structTester.notAsyncCall()
            classTester.notAsyncCall()
        }
        
        structTester.startTask()
        classTester.startTask()
    }
    
    private func notAsyncCall() {
        let message: String = mainThreadCheckMessage()
        print("$$ ViewController - notAsyncCall - ", message)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

func mainThreadCheckMessage() -> String {
    return Thread.isMainThread ? "on MainThread" : "not on MainThread"
}

private struct StructAsyncAwait {
    func test() async {
        try? await Task.sleep(nanoseconds: 1)
        let message: String = mainThreadCheckMessage()
        print("$$ StructAsyncAwait - ", message)
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
