//
//  InfiniteScrollView.swift
//  StudyiOS
//
//  Created by nylah.j on 1/30/24.
//

import UIKit

protocol InfiniteScrollViewDelegate {
    func optionChanged(to option: String)
}

class InfiniteScrollView: UIView {
    var selectedOption: String! {
        didSet {
            delegate?.optionChanged(to: selectedOption)
        }
    }
    var delegate: InfiniteScrollViewDelegate?
    
   var datasource: [String]? {
       didSet {
           modifyDataSource()
       }
   }
   
   private var _datasource: [String]? {
       didSet {
           setupContentView()
       }
   }
    
    private func modifyDataSource() {
        guard var tempInput = datasource, tempInput.count > 2 else {
            return
        }
        
        let firstLast = (tempInput.first!, tempInput.last!)
        tempInput.append(firstLast.0)
        tempInput.insert(firstLast.1, at: 0)
        
        print("$$ _dataSource set to:  \(tempInput)")
        self._datasource = tempInput
    }
    
    private func setupContentView() {
        let subviews = scrollView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        guard let data = _datasource else { return }
        
        self.scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(data.count), height: scrollView.frame.size.height)
        
        for i in 0..<data.count {
            var frame = CGRect()
            frame.origin.x = scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = scrollView.frame.size
            
            let label = UILabel(frame: frame)
            label.text = data[i]
            self.scrollView.addSubview(label)
        }
        
        let index = 1
        scrollView.contentOffset = CGPoint(x: scrollView.frame.width * CGFloat(index), y: 0)
        self.selectedOption = data[index]
        
    }

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor.red
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    lazy var tapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didReceiveTap(sender: )))
        return view
    }()
    
    @objc
    func didReceiveTap(sender: UITapGestureRecognizer) {
        guard let data = datasource else { return }
        
        var index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        index = index < data.count ? index : 0 // 순회시킨다?
        self.selectedOption = data[index]
        
        let x = scrollView.contentOffset.x
        let nextRect = CGRect(x: x + scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.scrollRectToVisible(nextRect, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        scrollView.frame = .init(x: self.bounds.width / 2, y: 0, width: self.bounds.width / 2, height: self.bounds.height)
        self.addSubview(scrollView)
        
        tapView.frame = self.bounds
        self.addSubview(tapView)
    }
}

extension InfiniteScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard _datasource != nil else { return }
        let x = scrollView.contentOffset.x
        if x >= scrollView.frame.width * CGFloat(_datasource!.count - 1) {
            self.scrollView.contentOffset = CGPoint(x: scrollView.frame.width, y: 0)
        } else if x < scrollView.frame.width {
            self.scrollView.contentOffset = CGPoint(x: scrollView.frame.width * CGFloat(_datasource!.count - 2), y: 0)
        }
    }
}
