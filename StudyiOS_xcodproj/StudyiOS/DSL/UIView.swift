//
//  UIView.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/26.
//

import UIKit

extension UIView {
    @discardableResult
    func label(apply closure: (UILabel) -> Void) -> UILabel {
        let label = UILabel()
        if let stack = self as? UIStackView {
            stack.addArrangedSubview(label)
        } else {
            addSubview(label)
        }
        
        closure(label)
        return label
    }
}
