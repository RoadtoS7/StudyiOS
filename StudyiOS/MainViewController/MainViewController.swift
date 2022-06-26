//
//  ViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import UIKit
class MainViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    // 어떤 데이터에 어떤 cell을 사용할지 맵핑해준다.
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = listLayout()
        
        // CellRegistration: Cell 등록 (CollectionView에서 보여줄 cell 마다 Cell
        // contentConfiguration: cell에서 데이터가 어떻게 나타낼지를 결정
        // DiffableDataSource.CellProvider: Cell을 contentConfiguration을 설정하여 제공
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = ViewType.value[indexPath.item].title
            cell.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        
        var snapShot = SnapShot()
        snapShot.appendSections([0])
        snapShot.appendItems(ViewType.value.map({ $0.title }))
        dataSource.applySnapshotUsingReloadData(snapShot)
        
        collectionView.dataSource = dataSource
    }
    
    // 어떤 layout을 만들지를 생성한다.
    private func listLayout() -> UICollectionViewLayout {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
}

