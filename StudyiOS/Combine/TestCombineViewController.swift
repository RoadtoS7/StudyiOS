//
//  TestCombineViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/26.
//

import UIKit
import Combine

class TestCombineViewController: UIViewController {
    private var cancellableBag = Set<AnyCancellable>()
    private let timerPublisher: CurrentValueSubject<Int, Never> = .init(0)

    override func viewDidLoad() {
        super.viewDidLoad()
//        generateAsyncRandomNumberFromFuture()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("error: \(error)")
//                }
//            } receiveValue: { value in
//                print("receive: \(value)")
//            }.store(in: &cancellableBag)
        
        testSinkClosureRetained()
        let frame: CGRect = .init(x: 0, y: 0, width: 100, height: 100)
        let button = UIButton(frame: frame)
        button.setTitle("정지", for: .normal)
        view.addSubview(button)
        button.addAction(.init(handler: { [unowned self] _ in
            self.cancelSubscribtion()
        }), for: .touchUpInside)
    }
    
    // Future: Future는 success 혹은 fail을 한번만 발행한 이후 finished 된다.
    func generateAsyncRandomNumberFromFuture() -> Future<Int, Error> {
        return Future() { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let number = Int.random(in: 1...10)
                    promise(Result.success(number))
                }
            }
    }
    
    // sink의 closure는 retain 되는가?
    func testSinkClosureRetained() {
        Timer.publish(every: 1, on: RunLoop.main, in: .default)
            .autoconnect()
            .sink { date in
                self.printDate(date)
            }.store(in: &cancellableBag)
    }
    
    private func printDate(_ date: Date) {
        print(date)
    }
    
    func cancelSubscribtion() {
        cancellableBag.removeAll()
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
