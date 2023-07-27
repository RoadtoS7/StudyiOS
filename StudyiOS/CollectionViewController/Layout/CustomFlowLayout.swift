//
//  CustomFlowLayout.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/07/21.
//

import UIKit

protocol CustomTabBarLayoutDelegate: AnyObject {
    func itemCount() -> Int
    func itemSize(indexPath: IndexPath) -> CGSize
    func spacing() -> CGFloat
}

class CustomTabBarLayout: UICollectionViewFlowLayout {
    weak var delegate: CustomTabBarLayoutDelegate?
    
    private var layoutAttributeCache: [UICollectionViewLayoutAttributes] = []
    
    private var prepareRequired: Bool = true
    
    private var lastCollectionViewContentWidth: CGFloat?
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: (layoutAttributeCache.last?.frame.maxX ?? .zero) + sectionInset.right,
                      height: (layoutAttributeCache.last?.frame.maxY ?? .zero))
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        if context.invalidateEverything
            || context.invalidatedDecorationIndexPaths != nil
            || context.invalidatedItemIndexPaths != nil
            || context.invalidatedSupplementaryIndexPaths != nil {
            prepareRequired = true
        }
        
        super.invalidateLayout(with: context)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributeCache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let index = indexPath.row
        if layoutAttributeCache.indices.contains(index) {
            return layoutAttributeCache[indexPath.row]
        }
        
        return nil
    }
    
    override func prepare() {
        super.prepare()
        print("$$ prepare")
        guard let delegate = delegate else { return }
        
        let currentWidth = collectionViewContentSize.width
        if let oldWidth = lastCollectionViewContentWidth {
            if oldWidth != currentWidth {
                prepareRequired = true
            }
        } else {
            prepareRequired = true
        }
        
        lastCollectionViewContentWidth = currentWidth
        
        guard prepareRequired else { return }
        prepareRequired = false
        
        layoutAttributeCache.removeAll(keepingCapacity: true)
        
        let count: Int = delegate.itemCount()
        for index in 0..<count {
            let indexPath: IndexPath = .init(row: index, section: 0)
            let size: CGSize = delegate.itemSize(indexPath: indexPath)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let lastFrameX = layoutAttributeCache.last?.frame.maxX
            let lastFrameY = layoutAttributeCache.last?.frame.minY ?? -minimumLineSpacing
            
            let x: CGFloat = lastFrameX.map {
                $0 + delegate.spacing()
            } ?? sectionInset.left
            
            let origin: CGPoint = .init(x: x, y: lastFrameY)
            
            
            attribute.frame = .init(origin: origin, size: size)
            
            layoutAttributeCache.append(attribute)
        }
    }
}
