//
//  MainActorViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/06/15.
//

import UIKit

/**
@MainActor로 지정한 메서드를 메인 스레드가 아닌 곳에서 호출하면 어떻게 되는가?
 */
class MainActorViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
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

@MainActor
class MainActorViewModel {
    let mainActorContainer = MainActorContainer()
    
    func test() {
        DispatchQueue.global().async {
            // compile error
//            self.mainActorContainer.mainActorMethod()
        }
        
        Task {
            // compile error
//            self.mainActorContainer.mainActorMethod()
        }
    }
    
    @MainActor
    func mainActorMethod() {
        self.mainActorContainer.mainActorMethod()
    }
    
    func testInAnyWhere() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.mainActorContainer.mainActorMethod()
            }
        }
        
        Task {
            await self.mainActorContainer.mainActorMethod()
        }
    }
}


class MainActorContainer {
    @MainActor
    func mainActorMethod() {
        return
    }
}
