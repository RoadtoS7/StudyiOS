//
//  NonSubviewsViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/07/27.
//
// UIViewController가 subview를 갖지 않을 때, viewWillLayout, viewDidLayout이 호출되는지 확인하기 위함
// 1번씩 호출된다.

import UIKit

class NonSubviewsViewController: UIViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("$$ viewDidLayoutSubviews")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("$$ viewWillLayoutSubviews")
    }
    
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
