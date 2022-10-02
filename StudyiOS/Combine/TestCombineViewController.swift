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

    override func viewDidLoad() {
        super.viewDidLoad()
        generateAsyncRandomNumberFromFuture()
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error: \(error)")
                }
            } receiveValue: { value in
                print("receive: \(value)")
            }.store(in: &cancellableBag)
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
