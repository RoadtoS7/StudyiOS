//
//  BaseTabBarController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/05/30.
//

import UIKit


protocol BaseTabBarControllerDelegate: AnyObject {
    func baseTabBarController(_ tabBarController: BaseTabBarController, willSelect viewController: UIViewController, at index: Int)
    func baseTabBarController(_ tabBarController: BaseTabBarController, didSelect viewController: UIViewController, at index: Int)
}

class BaseTabBarController: UIViewController, BaseTabBarContentViewDelegate {
    private var viewState: ViewState = .initialize
    
    enum ViewState: Int, Comparable {
        case initialize
        case didLoad
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
    
    var viewControllers: [UIViewController] = []
    {
        didSet {
            // 기존 뷰컨트롤러들 제거
            removeObservers()
            for vc in oldValue {
                removeChildViewController(vc)
            }
            
            // 새로운 뷰 컨트롤러로 설정
            currentViewController = nil
            
            for vc in viewControllers {
                vc.baseTabBarController = self
            }
            addObservers()

            contentView.capacity = viewControllers.count
            setSelectedIndex(currentIndex, animated: false)
            
            viewIfLoaded?.setNeedsLayout()
        }
    }
    
    // BaseTabBarController 내부에서만 사용
    private var currentViewController: UIViewController?
    // 외부 노출용
    var selectedViewController: UIViewController? {
        get {
            currentViewController
        }
        set {
            guard let vc = newValue, viewControllers.contains(vc) else { return }
            currentViewController = vc
        }
    }
    
    var interitemSpacing: CGFloat {
        get {
            contentView.interitemSpacing
        }
        set {
            contentView.interitemSpacing = newValue
        }
    }
    
    var scrollToSelectEnabled: Bool {
        get {
            contentView.isScrollEnabled
        }
        set {
            contentView.isScrollEnabled = newValue
        }
    }
    
    /// true이면, 양옆 뷰 컨트롤러 미리 로딩
    var preloadAdjacentViewControllers = false
    
    var contentInset: UIEdgeInsets {
        get {
            contentView.contentInset
        }
        set {
            contentView.contentInset = newValue
        }
    }
    
    var useChildViewControllerForToolbarItems = false {
        didSet {
            updateToolbarItems()
        }
    }
    
    var useChildViewControllerForNavigationTitle = false {
        didSet {
            updateNavigationTitle()
        }
    }
    
    var useChildViewControllerForNavigationButtons = false {
        didSet {
            updateNavigationButtons()
        }
    }
    
    
    var currentIndex: Int {
        get {
            currentViewController.flatMap { viewControllers.firstIndex(of: $0) } ?? 0
        }
        set {
            setSelectedIndex(newValue, animated: false)
        }
    }

    private(set) var contentView = BaseTabBarContentView()
    
    private var willSelectIndex: Int? = nil
    
    // view[Will|Did][Appear|Disappear] 에서 [begin|end]AppearanceTransition 호출을 싱크 할려고 사용
    private weak var appearanceTransitionVC: UIViewController?
    
    weak var delegate: BaseTabBarControllerDelegate?
    
    private func removeChildViewController(_ viewController: UIViewController) {
        viewController.baseTabBarController = nil
        
        if viewController.parent == self {
            willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
    
    deinit {
        contentView.delegate = nil
        
        removeObservers()
        // 기존 뷰컨트롤러들 제거
        for vc in viewControllers {
            removeChildViewController(vc)
        }
        viewControllers.removeAll()
        
        currentViewController = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewState = .didLoad
        view.backgroundColor = .black
        
        contentView.frame = view.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.delegate = self
        view.addSubview(contentView)
        
        setSelectedIndex(currentIndex, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewState = .willAppear
        appearanceTransitionVC = selectedViewController
        appearanceTransitionVC?.beginAppearanceTransition(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewState = .didAppear
        appearanceTransitionVC?.endAppearanceTransition()
        appearanceTransitionVC = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewState = .willDisappear
        appearanceTransitionVC = selectedViewController
        appearanceTransitionVC?.beginAppearanceTransition(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewState = .didDisappear
        appearanceTransitionVC?.endAppearanceTransition()
        appearanceTransitionVC = nil
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        false
    }
    
    override var shouldAutorotate: Bool {
        selectedViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        selectedViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        selectedViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    
    // MARK: - BaseTabBarContentViewDelegate
    func contentViewWillBeginDragging(_ contentView: BaseTabBarContentView) {
        baseTabBar?.isUserInteractionEnabled = false
    }
    func contentView(_ contentView: BaseTabBarContentView, willEndDraggingAt index: Int) {
        guard let tabBar = baseTabBar else { return }
        tabBar.isUserInteractionEnabled = true
        tabBar.setSelectedIndex(index, animated: true)
    }
    func contentView(_ contentView: BaseTabBarContentView, willSelectViewAt index: Int) {
        willSelectViewController(at: index, animated: true) { viewController, index in
            self.delegate?.baseTabBarController(self, didSelect: viewController, at: index)
        }
    }
    func contentView(_ contentView: BaseTabBarContentView, didSelectViewAt index: Int) {
        didSelectViewController(at: index, animated: true) { viewController, index in
            self.delegate?.baseTabBarController(self, didSelect: viewController, at: index)
        }
    }
    
    // MARK: - KVO Observer 관리
    private var keyValueObservations: [NSKeyValueObservation] = []
    
    private func addObservers() {
        viewControllers.forEach {
            addObserver(for: $0, keyPath: \.navigationItem.titleView) { [weak self] in
                self?.updateNavigationTitle()
            }
            addObserver(for: $0, keyPath: \.navigationItem.title) { [weak self] in
                self?.updateNavigationTitle()
            }
            addObserver(for: $0, keyPath: \.navigationItem.backBarButtonItem) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.hidesBackButton) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.leftBarButtonItems) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.rightBarButtonItems) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.leftItemsSupplementBackButton) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.leftBarButtonItem) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.navigationItem.rightBarButtonItem) { [weak self] in
                self?.updateNavigationButtons()
            }
            addObserver(for: $0, keyPath: \.toolbarItems) { [weak self] in
                self?.updateToolbarItems()
            }
        }
    }
    
    private func removeObservers() {
        keyValueObservations.forEach {
            $0.invalidate()
        }
        keyValueObservations.removeAll()
    }
    
    private func updateNavigationTitle() {
        let vc = useChildViewControllerForNavigationTitle ? currentViewController : self
        navigationItem.title = vc?.navigationItem.title
        navigationItem.titleView = vc?.navigationItem.titleView
    }
    
    private func updateNavigationButtons() {
        let vc = useChildViewControllerForNavigationButtons ? selectedViewController : self
        navigationItem.backBarButtonItem   = vc?.navigationItem.backBarButtonItem
        navigationItem.hidesBackButton     = vc?.navigationItem.hidesBackButton ?? false
        
        navigationItem.leftBarButtonItems  = vc?.navigationItem.leftBarButtonItems
        navigationItem.rightBarButtonItems = vc?.navigationItem.rightBarButtonItems
        
        navigationItem.leftItemsSupplementBackButton = vc?.navigationItem.leftItemsSupplementBackButton ?? false
        
        navigationItem.leftBarButtonItem   = vc?.navigationItem.leftBarButtonItem
        navigationItem.rightBarButtonItem  = vc?.navigationItem.rightBarButtonItem
    }
    
    private func updateToolbarItems() {
        let vc = useChildViewControllerForToolbarItems ? currentViewController : self
        toolbarItems = vc?.toolbarItems
    }
    
    
    private func addObserver<Value: Equatable>(for viewController: UIViewController,
                                               keyPath: KeyPath<UIViewController, Value>,
                                               changeHandler: @escaping () -> Void
    ) {
        let observer = viewController.observe(keyPath, options: [.new, .old]) { viewController, change in
            guard change.oldValue != change.newValue else { return }
            changeHandler()
        }
        keyValueObservations.append(observer)
    }
    
    // MARK: - subviewController 관리
    @discardableResult
    private func viewController(at index: Int) -> UIViewController? {
        guard let viewController = viewControllers[safe: index] else {
            return nil
        }
        
        if viewController.parent != self {
            addChild(viewController)
            contentView.addArrangedSubView(viewController.view, at: index)
            viewController.didMove(toParent: self)
        }
        
        return viewController
    }
    
    func setSelectedIndex(_ index: Int, animated: Bool) {
        setSelectedIndex(index, animated: animated, willSelectHandler: nil, didSelectHandler: nil)
    }
    
    private typealias SelectHandler = (UIViewController, Int) -> Void
    private func setSelectedIndex(_ index: Int,
                                   animated: Bool,
                                   willSelectHandler: SelectHandler?,
                                   didSelectHandler: SelectHandler?
    ) {
        if !viewControllers.isEmpty && isViewLoaded {
            var index = index
            if !viewControllers.indices.contains(index) {
                index = 0
            }
            
            if alreadySelectedIndex(index) {
                return
            }
            
            willSelectViewController(at: index, animated: true, selectHandler: willSelectHandler)
            didSelectViewController(at: index, animated: true, selectHandler: didSelectHandler)
        } else {
            currentViewController = viewControllers[safe: index]
            willSelectIndex = nil
        }
    }
    
    private func alreadySelectedIndex(_ index: Int) -> Bool {
        if let vc = currentViewController,
           vc.parent == self,
           vc == viewControllers[safe: index] {
            return true
        }
        return false
    }
    
    func selectNextIndex(canWrap: Bool = true) {
        offsetSelectedIndex(by: 1, canWrap: canWrap)
    }
    
    private func offsetSelectedIndex(by offset: Int, canWrap: Bool) {
        guard viewControllers.count > 1 else { return }
        let newIndex = currentIndex + offset
        if newIndex < 0 {
            if canWrap {
                currentIndex = viewControllers.endIndex - 1
            }
        }
        else if newIndex >= viewControllers.endIndex {
            if canWrap {
                currentIndex = 0
            }
        }
        else {
            currentIndex = newIndex
        }
    }
    
    private func willSelectViewController(at index: Int, animated: Bool, selectHandler: SelectHandler? = nil) {
        guard willSelectIndex != index else { return }
        guard let selectedVC = viewController(at: index) else { return }
        
        let willSelectIndex = self.willSelectIndex
        let selectedIndex = self.currentIndex
        
        self.willSelectIndex = index
        
        if .willAppear <= viewState && viewState < .didDisappear {
            selectedVC.beginAppearanceTransition(true, animated: animated)
            appearanceTransitionVC = selectedVC
            
            if willSelectIndex != nil {
                let vc = viewController(at: willSelectIndex!)
                vc?.beginAppearanceTransition(false, animated: false)
                vc?.endAppearanceTransition()
            }
            
            if selectedIndex != index && willSelectIndex == nil {
                let vc = viewController(at: selectedIndex)
                vc?.beginAppearanceTransition(false, animated: animated)
            }
             
            selectHandler?(selectedVC, index)
        }
    }
    
    private func didSelectViewController(at index: Int, animated: Bool, selectHandler: SelectHandler? = nil) {
        guard willSelectIndex != nil else { return }
        guard let selectedVC = viewController(at: index) else { return }
        
        // willSelectIndex 를 로컬 variable 에 저장해서 사용하는 이유는 탭바 터치로 여기로 진입했을시
        // 스크롤뷰 setContentOffset:animated: 가 호출되는데 탭바랑 스크롤뷰를 엄청 빨리 여러번 터치했을 경우 스크롤뷰의
        // scrollViewDidEndDecelerating 가 호출되는 경우있다. 이때 didSelectViewControllerAtIndex 가
        // 중간에서 부터 nested 로 호출되면서 inner 함수가 self.willSelectedIndex 를 NSNotFound 로 설정하면서 크래쉬가 생긴다.
        // 때문에 로컬 값을 사용하고 프로퍼티는 미리 업데이트 시켜놓는다.
        let willSelectIndex = self.willSelectIndex
        let selectedIndex = self.currentIndex
        
        self.willSelectIndex = nil
        
        if .willAppear <= viewState && viewState < .didDisappear {
            if willSelectIndex != index {
                let vc = viewController(at: index)
                vc?.beginAppearanceTransition(true, animated: animated)
            }
            
            selectedVC.endAppearanceTransition()
            appearanceTransitionVC = nil
            
            if willSelectIndex != index {
                let vc = viewController(at: willSelectIndex!)
                vc?.beginAppearanceTransition(false, animated: animated)
                vc?.endAppearanceTransition()
            }
            
            if selectedIndex != index {
                let currentVC = viewController(at: selectedIndex)
                currentVC?.endAppearanceTransition()
            }
        }
        
        currentViewController = selectedVC
        contentView.setSelectedIndex(index, animated: animated)
        updateNavigationBarAndToolbar()
        baseTabBar?.setSelectedIndex(index, animated: animated)
        baseTabBarControllerDidSelect(selectedVC, at: index)
        
        selectHandler?(selectedVC, index)
        
        // 양옆 뷰컨트롤러 미리 로딩
        if preloadAdjacentViewControllers {
            DispatchQueue.main.async {
                self.viewController(at: index+1)
            }
            DispatchQueue.main.async {
                self.viewController(at: index-1)
            }
        }
    }
    
    private func updateNavigationBarAndToolbar() {
        updateNavigationTitle()
    }
    
    // MARK: - baseTabBar 관련 동작
    var baseTabBar: BaseTabBar? {
        // subclass can override
        nil
    }
    
    func baseTabBarControllerDidSelect(_ viewController: UIViewController, at index: Int) {
        // subclass can override
    }
    
    func contentViewDidScroll(_ contentView: BaseTabBarContentView, toIndex index: Int, ratio: CGFloat, toRight: Bool) {
        // subclass can override
    }
}

extension BaseTabBarController {
    
    convenience init(viewController: UIViewController) {
        self.init(viewControllers: [viewController])
    }
    
    convenience init(viewControllers: [UIViewController]) {
        defer {
            // willSet/didSet 은 init 에서는 호출되지 않고 convenience init 에서도 동일하게 호출되지 않지만 defer 시키면 호출된다.
            self.viewControllers = viewControllers
        }
        self.init()
    }
    
    @objc var topViewController: UIViewController? {
        return topViewController(at: currentIndex)
    }
    
    func topViewController(at index: Int) -> UIViewController? {
        guard let vc = viewControllers[safe: index] else {
            return nil
        }
        if let navigationController = vc as? UINavigationController {
            return navigationController.topViewController
        } else {
            return vc
        }
    }
    
    func rootViewController(at index: Int) -> UIViewController? {
        guard let vc = viewControllers[safe: index] else {
            return nil
        }
        if let navigationController = vc as? UINavigationController {
            return navigationController.viewControllers[safe: 0]
        } else {
            return vc
        }
    }
    
    @objc func pushViewController(_ viewController: UIViewController, animated: Bool = false) {
        setSelectedIndex(currentIndex, popToRoot: false, pushViewController: viewController, animated: animated)
    }
    
    @objc func setSelectedIndex(_ index: Int, popToRoot: Bool, animated: Bool = false) {
        setSelectedIndex(index, popToRoot: popToRoot, pushViewController: nil, animated: animated)
    }
    
    @objc func setSelectedIndex(_ index: Int, popToRoot: Bool, pushViewController: UIViewController?, animated: Bool = false) {
        guard let selectedVC = viewControllers[safe: index] else {
            return
        }
        let isSameIndex = currentIndex == index
        currentIndex = index

        if let navigationController = selectedVC as? UINavigationController {
            if let pushVC = pushViewController {
                if popToRoot && navigationController.viewControllers.count > 1 {
                    // 같은 탭에서 root으로 팝하고 뷰컨트롤러를 푸시할때는 애니메이션을 끊다.
                    let rootVC = navigationController.viewControllers[0]
                    navigationController.setViewControllers([rootVC, pushVC], animated: (isSameIndex ? false : animated))
                } else {
                    navigationController.pushViewController(pushVC, animated: animated)
                }
            } else if popToRoot {
                navigationController.popToRootViewController(animated: animated)
            }
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
}

extension BaseTabBarController {
    func setSelectedIndexWithDelegateCallback(_ index: Int, animated: Bool) {
        setSelectedIndex(index, animated: animated, willSelectHandler: { viewController, index in
            self.delegate?.baseTabBarController(self, willSelect: viewController, at: index)
        }, didSelectHandler: { viewController, index  in
            self.delegate?.baseTabBarController(self, didSelect: viewController, at: index)
        })
    }
}

// MARK: - baseTabbarController
private var baseTabBarControllerKey = 0

extension UIViewController {
    
    @objc fileprivate(set) var baseTabBarController: BaseTabBarController? {
        get {
            return objc_getAssociatedObject(self, &baseTabBarControllerKey) as? BaseTabBarController
        }
        set {
            // Weak reference assignment
            objc_setAssociatedObject(self, &baseTabBarControllerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

