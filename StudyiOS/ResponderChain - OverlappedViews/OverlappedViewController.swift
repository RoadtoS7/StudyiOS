//
//  OverlappedViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/12/27.
//
// [Alter Responder Chain: Responder Chain 변경하기]
// first


import UIKit


class OverlappedViewController: UIViewController {
    private var touchableResponderView: FirstResponderView!
    private var blueToucableResponderView: NotFirstResponderView!
    
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

extension OverlappedViewController {
    private func initLayout() {
        view.backgroundColor = .white
        
        let touchableResponderView: FirstResponderView = .init()
        touchableResponderView.translatesAutoresizingMaskIntoConstraints = false
        touchableResponderView.backgroundColor = .orange
        self.touchableResponderView = touchableResponderView
        view.addSubview(touchableResponderView)
        
        let blueToucableResponderView: NotFirstResponderView = .init()
        blueToucableResponderView.translatesAutoresizingMaskIntoConstraints = false
        blueToucableResponderView.backgroundColor = .blue
        self.blueToucableResponderView = blueToucableResponderView
        view.addSubview(blueToucableResponderView)
        
        NSLayoutConstraint.activate([
            touchableResponderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            touchableResponderView.topAnchor.constraint(equalTo: view.topAnchor),
            touchableResponderView.widthAnchor.constraint(equalToConstant: 200),
            touchableResponderView.heightAnchor.constraint(equalToConstant: 400),
            
            blueToucableResponderView.leadingAnchor.constraint(equalTo: touchableResponderView.trailingAnchor, constant: -100),
            blueToucableResponderView.topAnchor.constraint(equalTo: view.topAnchor),
            blueToucableResponderView.widthAnchor.constraint(equalToConstant: 200),
            blueToucableResponderView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}

class FirstResponderView: UIView {
    override var canBecomeFirstResponder: Bool { true }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        print("FirstResponderView touchesMoved")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("FirstResponderView touchesCancelled")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("FirstResponderView touchesEnded")
    }
}

class NotFirstResponderView: UIView {
    override var canBecomeFirstResponder: Bool { false } // default가 false이다.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("NotFirstResponderView touches began")
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
        print("NotFirstResponderView touchesMoved")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("NotFirstResponderView touchesCancelled")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("NotFirstResponderView touchesEnded")
    }
}
