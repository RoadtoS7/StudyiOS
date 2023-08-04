//
//  GCDViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/08/04.
//

import UIKit

class GCDViewController: UIViewController {
    private var workItem: DispatchWorkItem?
    private var animationStorage: UIViewPropertyAnimator?
    private var closureParameter: ClosureParameter = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GCDViewController"
        view.backgroundColor = .white
        
        // test code
        notRetainMultipleObject()
    }
    

    deinit {
        print("$$ AsycnSyncSerialConcurrent - deinit")
    }
}

extension GCDViewController {
    /***
     Synk: 동기 -> 호출하는 쪽의 실행순서 보장 (block이 실행완료된 후에 다음 코드 라인으로 넘어감)
     Asynk: 비동기
     */

    /**
     Serial: 큐에 쌓이는 작업 간에 순서 보장
     Concurrent: 큐에 쌓이는 작업간에 순서 보장 안됨
     */
        
    /// retain cycle이 발생하지 않는 코드들 이유: 바로 실행되고 종료되기 때문
    func asyncAfter() {
        // escaping closure
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.backgroundColor = .red
            print("$$ asyncAfter - escaping closure")
        }
        
        // escaping closure
        DispatchQueue.main.async {
            self.view.backgroundColor = .yellow
            print("$$ async - escaping closure")
        }
        
        // escaping closure
        // DispatchQueue.main.sync -> error 발생 -> serial queue에서 deadlock 발생 가능
        DispatchQueue.global(qos: .background).async {
           print(self.navigationItem.description) // warning 발생 -> UI요소는 메인 스레드에서만 접근 가능
        }
    }
    
    /// retain cycle 발생
    func leakyDispatchQueue() {
        let workItem = DispatchWorkItem {
            self.view.backgroundColor = .red
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        self.workItem = workItem // self에서 workItem 을 저장하기 때문
    }
    
    func notRetainAnimation() {
        let anim = UIViewPropertyAnimator(duration: 2.0, curve: .easeOut) {
            self.view.backgroundColor = .red
        }
        anim.addCompletion { _ in
            self.view.backgroundColor = .white
        }
        anim.startAnimation()
    }
    
    // closure <-> self, retain 사이클 발생
    func retainAnimation() {
        let anim = UIViewPropertyAnimator(duration: 2.0, curve: .easeOut) {
            self.view.backgroundColor = .red
        }
        anim.addCompletion { _ in
            self.view.backgroundColor = .white
        }
        self.animationStorage = anim
    }
    
    class ClosureParameter {
        var closure: (() -> Void)?
    }
    
    func retainClosureParamter() {
        closureParameter.closure = printer
    }
    
    func notRetainParamter() {
        closureParameter.closure = { [weak self] in
            self?.printer()
        }
    }
    
    private func printer() {
        print("$$ closure parameter")
    }
}

// MARK: weak self 외의 해결책
// UIViewPropertyAnimator의 closure 내부에서 self에 대한 참조가 발생하지 않는다.
extension GCDViewController {
    func setUpAnimation() {
        let view = self.view
        let anim = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            view?.backgroundColor = .red // self 참조X, view만 참조
        }
        anim.addCompletion { _ in
            view?.backgroundColor = .white
        }
        self.animationStorage = anim
    }
    
    func notRetainMultipleObject() {
        let context = (
            view: view,
            navigationItem: navigationItem,
            parent: parent
        )
        let anim = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            context.view?.backgroundColor = .red
            context.navigationItem.rightBarButtonItems?.removeAll()
            context.parent?.view.backgroundColor = .white
        }
        self.animationStorage = anim
        self.animationStorage?.startAnimation()
    }
}
