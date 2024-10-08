//
//  ResponderChainViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/12/27.
//
// responder chain 과 관련한 ViewController

import UIKit

class ResponderChainViewController: UIViewController {
    private var touchableResponderView: TouchableResponderView!
    private var blueToucableResponderView: TouchableResponderView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
}

extension ResponderChainViewController {
    private func initLayout() {
        view.backgroundColor = .white
        
        let touchableResponderView: TouchableResponderView = .init()
        touchableResponderView.translatesAutoresizingMaskIntoConstraints = false
        touchableResponderView.backgroundColor = .orange
        self.touchableResponderView = touchableResponderView
        view.addSubview(touchableResponderView)
        
        let blueToucableResponderView: TouchableResponderView = .init()
        blueToucableResponderView.translatesAutoresizingMaskIntoConstraints = false
        blueToucableResponderView.backgroundColor = .blue
        self.blueToucableResponderView = blueToucableResponderView
        view.addSubview(blueToucableResponderView)
        
        NSLayoutConstraint.activate([
            touchableResponderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            touchableResponderView.topAnchor.constraint(equalTo: view.topAnchor),
            touchableResponderView.widthAnchor.constraint(equalToConstant: 200),
            touchableResponderView.heightAnchor.constraint(equalToConstant: 400),
            
            blueToucableResponderView.leadingAnchor.constraint(equalTo: touchableResponderView.trailingAnchor),
            blueToucableResponderView.topAnchor.constraint(equalTo: view.topAnchor),
            blueToucableResponderView.widthAnchor.constraint(equalToConstant: 200),
            blueToucableResponderView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}

