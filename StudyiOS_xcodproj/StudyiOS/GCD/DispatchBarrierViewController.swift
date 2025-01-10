//
//  DispatchBarrierViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 12/17/24.
//

import UIKit

/**
 DispatchBariier는 concurrent queue에서만 사용할 수 있다.
 언제 사용하는가?
 */

class YourThreadSafeImages {
    private let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    private var images: [String] = [] // 공유 자원

    // 읽기 작업: 여러 스레드가 동시에 수행 가능
    func getImages() -> [String] {
        concurrentQueue.sync {
            return images
        }
    }

    // 쓰기 작업: DispatchBarrier를 사용하여 배타적으로 실행
    func addImage(_ image: String) {
        concurrentQueue.async(flags: .barrier) {
            self.images.append(image)
        }
    }

    func removeImage(at index: Int) {
        concurrentQueue.async(flags: .barrier) {
            guard index >= 0 && index < self.images.count else { return }
            self.images.remove(at: index)
        }
    }
}

class MyThreadSafeImages {
    private let serialQueue = DispatchQueue(label: "com.example.concurrentQueue")
    private var images: [String] = [] // 공유 자원

    // 읽기 작업: 여러 스레드가 동시에 수행 가능
    func getImages() -> [String] {
        serialQueue.sync {
            images
        }
    }

    // 쓰기 작업: DispatchBarrier를 사용하여 배타적으로 실행
    func addImage(_ image: String) {
        serialQueue.sync {
            self.images.append(image)
        }
    }

    func removeImage(at index: Int) {
        serialQueue.sync {
            guard index >= 0 && index < self.images.count else { return }
            self.images.remove(at: index)
        }
    }
}

class DispatchBarrierViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startSample()
    }
    
    func startSample() {
        // 사용 예시
        let threadSafeImages = YourThreadSafeImages()

        DispatchQueue.global().async {
            for _ in 0..<5 {
                threadSafeImages.addImage("Image1")
            }
        }

        DispatchQueue.global().async {
            for _ in 0..<5 {
                print(threadSafeImages.getImages())
            }
        }
    }
}
