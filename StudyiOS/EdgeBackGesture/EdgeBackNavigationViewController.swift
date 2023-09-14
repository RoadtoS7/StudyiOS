//
//  EdgeBackNavigationViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/09/08.
//

import UIKit
import Combine

class CustomNavigationTopTracker {
    private var topViewController: UIViewController?
    
    func set(_ topViewController: UIViewController?) {
        self.topViewController = topViewController
    }
}

class CustomUINavigationContrller: UINavigationController {
    var cancellables: Set<AnyCancellable> = .init()
    private let tracker: CustomNavigationTopTracker = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.publisher(for: \.topViewController)
            .sink {
                print("$$ CustomUINavigationController: ", $0)
            }
            .store(in: &cancellables)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        print("$$ pushViewController")
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        print("$$ popViewController")
        return vc
    }
}

class EdgeBackNavigationViewController: UIViewController {
    private let button: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("push new VC", for: .normal)
        return $0
    }(UIButton())
    
    private var anyCancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addAction(.init(handler: { _ in
            self.navigationController?.pushViewController(GreenViewController(), animated: true)
        }), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 200),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationController?.publisher(for: \.topViewController)
            .sink(receiveValue: {
                print("$$ topViewController: ", $0)
                // 가장 topViewController에 있을 때에만 동작한다.
            })
            .store(in: &anyCancellables)
        
        
        if let interactivePopGestureRecognizer = navigationController?.interactivePopGestureRecognizer {
//            interactivePopGestureRecognizer.addTarget(self, action: #selector(handlePopGesture(gesture:)))
        }
    }
    
    @objc private func handlePopGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            print("$$ ended: ", navigationController?.topViewController)
            
        case .changed:
            print("$$ changed: ", navigationController?.topViewController)
            
        case .began:
            print("$$ began: ", navigationController?.topViewController)
            
        case .cancelled:
            print("$$ cancelled")
        default: // default 인 경우 없는 것으로 확인됨
            print("$$ HomeNavigationController edge back default state")
        }
    }
}

extension EdgeBackNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        print("$$ from: ", fromVC, ", to: ", toVC)
        return nil
    }
}

extension EdgeBackNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        print("$$ interaction controller for")
        return nil
    }
}

fileprivate class GreenViewController: UIViewController {
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationController?.publisher(for: \.topViewController)
            .sink(receiveValue: {
                print("$$ Green topViewController: ", $0)
            })
            .store(in: &anyCancellables)
    }
}

fileprivate class EdgeBackNavigationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
//        print("$$ EdgeBackNavigationTransitioning fromVC: ", fromVC, "toVC: ", toVC)
    }
}

