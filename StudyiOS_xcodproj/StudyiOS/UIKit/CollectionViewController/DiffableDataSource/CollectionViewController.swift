//
//  CollectionViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    private var dataSource: DataSource!
    
    convenience init() {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
        self.init(collectionViewLayout: layout)
        
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout

        // CellRegistration: 데이터와 cell 연결
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        // DataSource: 데이터를 담당, cell을 만드는 역할
        // 데이터를 변경하고 그에 따라 UI를 변경할 수 있는 방법 제공
        // CellProvider 역할: 어떤 데이터에 어떤 cell을 사용할 것인지 결정 (cellRegistration을 이용하여 특정 cell을 꺼냄,
        // indexPath: cell이 나타나는 위치
        // item: 어떤 item과 cell을 연결할 것인가?
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        // DiffableDataSource는 데이터를 snapShot으로 다룬다.
        var snapShot = SnapShot()
        // 뷰로 보여줄 Section Identifier지정
        snapShot.appendSections([0])
        // 스냅샷에서 어떤 Section에 어떤 Item을 기록해둘지를 지정 (item identity)
        snapShot.appendItems(Reminder.sampleData.map({ $0.title }))
        dataSource.applySnapshotUsingReloadData(snapShot)
        
        collectionView.dataSource = dataSource
    }
    private func listLayout() -> UICollectionViewCompositionalLayout {
        // TODO: a(ppearance에 따라서 어떻게 나타나는 것일까?
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // list(): 주어진 configuration 대로 생성된 section의 list를 나타낼 때 사용
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
