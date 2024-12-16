//
//  DictViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 12/16/24.
//

import UIKit

class DictViewController: UIViewController {
    private var dict: [String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        applyNil()
        testValueTypeCapture()
        
    }
    
    // key1의 존재할 때와 존재하지 않을 때, nild을 할당하는 것은 에러를 일으키지 않는다.
    func applyNil() {
        var dict: [String:String] = [:]
        dict["key1"] = "value1"
        dict["key1"] = nil
        dict["key1"] = nil
    }
    
    func testValueTypeCapture() {
        let closure = { [dict] in
            print("$$ dict: \(dict)")
        }
        
        dict["key1"] = "value1"
        closure()
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
