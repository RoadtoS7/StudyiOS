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
