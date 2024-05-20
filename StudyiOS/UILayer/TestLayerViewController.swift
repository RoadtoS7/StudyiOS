//
//  TestLayerViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 12/27/23.
//

import UIKit

class TestLayerViewController: UIViewController {
    let baseView: UIView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.frame = .init(x: 10, y: 10, width: 200, height: 200)
        baseView.backgroundColor = .blue
        view.addSubview(baseView)
        
        // circle
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100),
                                  cornerRadius: baseView.bounds.width / 2).cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.yellow.cgColor
        layer.lineWidth = 5
        baseView.layer.addSublayer(layer)
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
