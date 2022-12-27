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
        
        NSLayoutConstraint.activate([
            touchableResponderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            touchableResponderView.topAnchor.constraint(equalTo: view.topAnchor),
            touchableResponderView.widthAnchor.constraint(equalToConstant: 200),
            touchableResponderView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}

class TouchableResponderView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        touches.forEach { touch in
            print("altitudeAngle: \(touch.altitudeAngle)")
            print("force: \(touch.force)")
            print("majorRadius: \(touch.majorRadius)")
            print("maximumPossibleForce: \(touch.maximumPossibleForce)")
            print("tapCount: \(touch.tapCount)")
            print("majorRadiusTolerance: \(touch.majorRadiusTolerance)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
    }
}
