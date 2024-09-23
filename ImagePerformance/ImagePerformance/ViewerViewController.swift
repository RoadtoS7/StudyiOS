//
//  ViewerViewController.swift
//  ImagePerformance
//
//  Created by nylah.j on 9/23/24.
//

import Foundation
import UIKit

final class ViewerViewController: UIViewController {
    private let scrollView: UIScrollView = .init()
    private lazy var contentView: UIStackView = .init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    
    private var size: CGSize {
        self.view.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.frame = CGRect(x: .zero, y: .zero, width: size.width, height: size.height)
        
        view.addSubview(scrollView)
        
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue]
        
        (0..<5).forEach { id in
            let rect = CGRect(x: 0,
                              y: CGFloat(id) * size.width,
                              width: size.width,
                              height: size.width)
            let subView = UIView(frame: rect)
            subView.backgroundColor = colors[id]
            scrollView.addSubview(subView)
        }
        
        scrollView.contentSize = scrollView.subviews.reduce(CGSize(width: 0, height: 0), { partialResult, view in
            CGSize(width: size.width, height: partialResult.height + view.frame.height)
        })
    }
}
