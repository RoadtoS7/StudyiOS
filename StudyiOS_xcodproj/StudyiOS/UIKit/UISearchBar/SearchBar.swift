//
//  SearchBar.swift
//  StudyiOS
//
//  Created by nylah.j on 1/10/25.
//

import Foundation
import UIKit

final class SearchBar: UISearchBar, UISearchBarDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        // placeholder 프로퍼티를 사용할 수도 있지만, 이런 경우 스타일을 적용할 수 없다.
        // attributedPlaceholder를 사용할 때만 텍스트 색상 변경 가능
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력", attributes: [.foregroundColor : UIColor.red])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 언어를 업데이트하기 위해선, NSLocalizedString으로 다시 업데이트하는 것이 필요 
    func changePlaceholderLanguage() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력", attributes: [.foregroundColor : UIColor.red])
    }
    
    func resetTextField() {
        searchTextField.text = ""
    }
}
