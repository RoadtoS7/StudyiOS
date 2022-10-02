//
//  String+Extension.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/07/07.
//

import Foundation
import UIKit

extension String {
    func rect(font: UIFont) -> CGRect {
        let label = UILabel(frame: .zero)
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame
    }
}

extension String {
    static func pointer(_ object: AnyObject?) -> String {
        guard let object = object else { return "nil" }
        let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
        return String(describing: opaque)
    }
}
