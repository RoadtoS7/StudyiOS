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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
        }
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableSupplementary(using: cellRegistration, for: indexPath)
        })
        collectionView.dataSource = dataSource
        

    }
}

