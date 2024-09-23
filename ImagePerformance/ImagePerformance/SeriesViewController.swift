//
//  SeriesViewController.swift
//  ImagePerformance
//
//  Created by nylah.j on 9/23/24.
//

import Foundation
import UIKit

final class SeriesViewController: UINavigationController {
    private let button = UIButton(frame: CGRect(x: 10, y: 10, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.backgroundColor = .white
        
        button.backgroundColor = .red
        button.addAction(.init(handler: { _ in
            self.pushViewController(ViewerViewController(), animated: true)
        }), for: .touchUpInside)
    }
}


final class ViewerImageURLLoader {
    
}
