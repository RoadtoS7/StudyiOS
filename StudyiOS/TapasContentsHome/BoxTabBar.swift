//
//  BoxTabBar.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/09/14.
//

import Foundation

//class BoxTabBar: UIView, BaseTabBar {
//    override var intrinsicContentSize: CGSize {
//        // 네비게이션바에 꽉 차게 보여야 하기 때문에 가장 큰 사이즈를 사용한다.
//        CGSize(width: UIView.layoutFittingExpandedSize.width, height: 44.0)
//    }
//
//    /// 직접 참조하지 않고, selectedIndex를 통해 참조한다.
//    private var _selectedIndex: Int?
//    private var selectedIndex: Int? {
//        set {
//            switchSelectedTab(from: _selectedIndex, to: newValue)
//        }
//        get {
//            _selectedIndex
//        }
//    }
//
//
//
//    // BaseTabBar
//    func setSelectedIndex(_ selectedIndex: Int?, animated: Bool) {
//        self.selectedIndex = selectedIndex
//    }
//}
