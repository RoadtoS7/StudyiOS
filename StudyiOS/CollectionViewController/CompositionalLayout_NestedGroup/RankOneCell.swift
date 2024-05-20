//
//  RankOneCell.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/10/03.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

class RankOneCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder: NSCoder?) {
        fatalError("not implemented ")
    }
}

extension RankOneCell {
    func initView() {
        // TODO: implement
    }
}

class RankOtherCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder: NSCoder?) {
        fatalError("not implemented ")
    }
}

extension RankOtherCell {
    func initView() {
        
    }
}

