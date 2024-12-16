//
//  AutoResizingMaskViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 11/1/24.
//

import UIKit

class AutoResizingMaskViewController: UIViewController {
    // Make one subview which has red color and set autoresizing mask
    override func viewDidLoad() {
        super.viewDidLoad()
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        redView.backgroundColor = .red
        redView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(redView)
    }
}
