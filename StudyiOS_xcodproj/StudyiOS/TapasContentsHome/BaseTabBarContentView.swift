//
//  BaseTabBarContentView.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/05/30.
//

import UIKit

protocol BaseTabBarContentViewDelegate: AnyObject {
    func contentViewWillBeginDragging(_ contentView: BaseTabBarContentView)
    func contentView(_ contentView: BaseTabBarContentView, willEndDraggingAt index: Int)
    func contentView(_ contentView: BaseTabBarContentView, willSelectViewAt index: Int)
    func contentView(_ contentView: BaseTabBarContentView, didSelectViewAt index: Int)
    func contentViewDidScroll(_ contentView: BaseTabBarContentView, toIndex index: Int, ratio: CGFloat, toRight: Bool)
}

class BaseTabBarContentView: UIView {
    var interitemSpacing: CGFloat = 0 {
        didSet {
            guard let scrollViewWidth = scrollViewWidth else { return }
            scrollViewWidth.constant = interitemSpacing
        }
    }
    
    var isScrollEnabled: Bool {
        get {
            scrollView.isScrollEnabled
        }
        set {
            scrollView.isScrollEnabled = newValue
        }
    }
    
    var contentInset: UIEdgeInsets {
        get {
            scrollView.contentInset
        }
        set {
            scrollView.contentInset = newValue
        }
    }
    
    var capacity: Int {
        set {
            arrangedSubviews.forEach { $0?.removeFromSuperview() }
            arrangedSubviews = Array(repeating: nil, count: newValue)
        }
        get {
            arrangedSubviews.count
        }
    }
    
    private var scrollView: UIScrollView!
    
    private var scrollViewWidth: NSLayoutConstraint!
    
    private var arrangedSubviews: [UIView?] = []
    
    private var selectedIndex = 0
    
    private var prevContentOffsetX: CGFloat = 0.0
    
    weak var delegate: BaseTabBarContentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollViewWidth = scrollView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollViewWidth,
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        self.scrollView = scrollView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scrollSize: CGSize = scrollView.bounds.size
        let viewSize: CGSize = .init(width: bounds.width, height: scrollSize.height)
        
        let scrollableWidth: CGFloat = scrollSize.width * CGFloat(arrangedSubviews.count)
        let contentSize: CGSize = .init(width: scrollableWidth, height: scrollSize.height)
        scrollView.contentSize = contentSize
        
        var xOrigin: CGFloat = 0.0
        for view in arrangedSubviews {
            if let view = view {
                var frame = CGRect(origin: .zero, size: viewSize)
                frame.origin.x = xOrigin + (interitemSpacing / 2.0)
                view.frame = frame
            }
            xOrigin += scrollSize.width
        }
        
        if !scrollView.isDragging && !scrollView.isDecelerating {
            setScrollViewOffset(at: selectedIndex, animated: false)
        }
    }
    
    func addArrangedSubView(_ view: UIView, at index: Int) {
        guard arrangedSubviews.indices.contains(index) else { return }
        
        if let view = arrangedSubviews[index] {
            view.removeFromSuperview()
        }
        
        arrangedSubviews[index] = view
        scrollView.addSubview(view)
        setNeedsLayout()
    }
    
    func setSelectedIndex(_ index: Int, animated: Bool) {
        selectedIndex = index
        setScrollViewOffset(at: index, animated: animated)
    }
}

extension BaseTabBarContentView: UIScrollViewDelegate {
    private func setScrollViewOffset(at index: Int, animated: Bool) {
        let newOffsetX = scrollView.bounds.width * CGFloat(index)
        guard newOffsetX != scrollView.contentOffset.x else { return }
        
        var contentOffset = scrollView.contentOffset
        contentOffset.x = newOffsetX
        
        if animated && isScrollEnabled {
            UIView.animate(withDuration: 0.25) {
                self.scrollView.contentOffset = contentOffset
            }
        } else {
            scrollView.contentOffset = contentOffset
        }
        
        prevContentOffsetX = contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateContentViewDidScroll(scrollView: scrollView, prevContentOffsetX: prevContentOffsetX)
        
        guard scrollView.isTracking else { return }
        let contentOffsetX: CGFloat = scrollView.contentOffset.x

        var index: Int = selectedIndex
        if contentOffsetX < 0 {
            index = 0
        }
        else if prevContentOffsetX < contentOffsetX {
            index = toIndex(ofScrollView: scrollView, prevContentOffsetX: prevContentOffsetX)
        }
        else if prevContentOffsetX > contentOffsetX {
            index = toIndex(ofScrollView: scrollView, prevContentOffsetX: prevContentOffsetX)
        }
        
        if index != selectedIndex {
            delegate?.contentView(self, willSelectViewAt: index)
        }
    }
    
    private func delegateContentViewDidScroll(scrollView: UIScrollView, prevContentOffsetX: CGFloat) {
        let width: CGFloat = scrollView.bounds.width
        let contentOffsetX: CGFloat = scrollView.contentOffset.x
        let scrolledOffset: CGFloat = contentOffsetX.truncatingRemainder(dividingBy: width)
        let index: Int = toIndex(ofScrollView: scrollView, prevContentOffsetX: prevContentOffsetX)
        
        var ratio = scrolledOffset / width
        let toRight: Bool = prevContentOffsetX < contentOffsetX
        if toRight && ratio == .zero {
            ratio = 1.0
        }
        
        delegate?.contentViewDidScroll(self, toIndex: index, ratio: ratio, toRight: toRight)
    }
    
    private func toIndex(ofScrollView scrollView: UIScrollView, prevContentOffsetX: CGFloat) -> Int {
        let width: CGFloat = scrollView.bounds.width
        let contentOffsetX: CGFloat = scrollView.contentOffset.x
        let toRight: Bool = prevContentOffsetX < contentOffsetX
        
        return toRight ? Int(ceilf(Float(contentOffsetX / width))) : Int(floorf(Float(contentOffsetX / width)))
    }
 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        prevContentOffsetX = scrollView.contentOffset.x
        delegate?.contentViewWillBeginDragging(self)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / scrollView.bounds.size.width)
        delegate?.contentView(self, willEndDraggingAt: index)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewScrollingEnded(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewScrollingEnded(scrollView)
    }
    
    private func scrollViewScrollingEnded(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        setSelectedIndex(index, animated: false)
        delegate?.contentView(self, didSelectViewAt: index)
    }
}
