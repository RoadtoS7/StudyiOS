//
//  TextViewContainer.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/08.
//

import Foundation
import UIKit

class TextViewContainer: UIView {
    private static let seeMore = "보기"
    
    let textView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.isEditable = false
        $0.setContentHuggingPriority(.required, for: .horizontal)
        return $0
    }(UITextView())
    
    let seeMoreTextView: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .red
        $0.text = "보기"
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ text: String) {
        super.init(frame: .zero)
        textView.text = text
        textView.sizeToFit()
        self.addSubview(textView)
        self.addSubview(seeMoreTextView)
        
        NSLayoutConstraint.activate([
            
            centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            seeMoreTextView.firstBaselineAnchor.constraint(equalTo: textView.lastBaselineAnchor),
            seeMoreTextView.leadingAnchor.constraint(equalTo: textView.contentLayoutGuide.trailingAnchor),
           seeMoreTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
