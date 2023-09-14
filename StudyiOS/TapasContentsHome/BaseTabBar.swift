//
//  BaseTabBar.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/05/30.
//

import UIKit

protocol BaseTabBar: UIView {
    func setSelectedIndex(_ selectedIndex: Int?, animated: Bool)
}
