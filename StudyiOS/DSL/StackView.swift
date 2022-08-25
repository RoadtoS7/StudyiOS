//
//  StackView.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/08/26.
//

import Foundation
import UIKit

public func stackview(apply closure: (UIStackView) -> Void) -> UIStackView {
    let stack = UIStackView()
    closure(stack)
    return stack
}

extension UIStackView {
    @discardableResult
    
}
