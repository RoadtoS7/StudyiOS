//
//  DiffableCollectionView.swift
//  StudyiOS
//
//  Created by 김수현 on 9/6/24.
//

import Foundation
import UIKit

final class DiffableCollectionView: UIViewController {
    typealias SectionId = Int
    typealias ItemId = Int
    typealias DataSource = UICollectionViewDiffableDataSource<SectionId, ItemId>
    private let collectionView: UICollectionView =  .init(frame: .zero)
    private var dataSource: DataSource!
    var items: [Int] = (0...10).map { $0 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typealias CellItem = Int
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CellItem> { cell, indexPath, itemIdentifier in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "(row: \(indexPath.row)) (item: \(indexPath.item))  (section: \(indexPath.section)"
            cell.contentConfiguration = contentConfig
            
        }

        // escpaing closure이다.
        // strong refrence cycle이 발생할 우려가 있는가?
        // self가 dataSource를 갖는다. dataSource가 closure를 갖는다.
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: self.items[itemIdentifier])
        })
        collectionView.dataSource = dataSource
        

    }
}

