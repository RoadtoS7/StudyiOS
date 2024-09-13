//
//  InfiniteScrollViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 1/30/24.
//

import UIKit

class InfiniteScrollViewController: UIViewController {
    private var infiniteScrollView: InfiniteScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.infiniteScrollView = InfiniteScrollView(frame: CGRect(x: 0, y: 300, width: self.view.bounds.width, height: 40))
        self.view.addSubview(infiniteScrollView)
        
        
        self.infiniteScrollView.datasource = ["option one", "option two", "option three", "option four"]
        self.infiniteScrollView.delegate = self
    }
}

extension InfiniteScrollViewController: InfiniteScrollViewDelegate {
    func optionChanged(to option: String) {
        print("$$ delegate called with option : \(option)")
    }
}
