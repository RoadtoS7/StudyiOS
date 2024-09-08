//
//  ViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import UIKit
import SwiftUI

class MainViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    let label: UILabel = {
        let label = UILabel()
        label.text = "please tab me!"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // 어떤 데이터에 어떤 cell을 사용할지 맵핑해준다.
    var dataSource: DataSource!
    var tapArea: CGRect!
    
    convenience init() {
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
        self.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// test view 복사시 reference 복사되는지 체크
        let view = UIView()
        let otherView = view
        
        withUnsafePointer(to: view) { pointer in
            print("view address: \(String.pointer(view))")
        }
        
        withUnsafePointer(to: otherView) { pointer in
            print("otherview address: \(String.pointer(otherView))")
        }
        
        let number: Int = 10
        let otherNumber = number
        withUnsafePointer(to: number) { pointer in
            print("number address: \(pointer)")
        }
        
        withUnsafePointer(to: otherNumber) { pointer in
            print("other number address: \(pointer)")
        }
        
        // CellRegistration: Cell 등록 (CollectionView에서 보여줄 cell 마다 Cell
            // contentConfiguration 생성
            // contentConfiguration과 Cell 연결
        // contentConfiguration: cell에서 데이터가 어떻게 나타낼지를 결정
        
        view.backgroundColor = .white
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let viewType = ViewType.value[indexPath.item]
            var configuration = cell.defaultContentConfiguration()
            configuration.text = viewType.title
            configuration.textProperties.color = UIColor.darkGray
            cell.contentConfiguration = configuration
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.cornerRadius = 8
            cell.backgroundConfiguration = backgroundConfig
        }
        
        // dataSource 이니셜라이저는 cellProvider를 받는다.
        // cell Provider는 cell pool에서 알맞은 cell을 꺼내서 반환한다.
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
        // list layout에서 섹션 하나를 만든다.
        var layoutConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        layoutConfiguration.showsSeparators = false
        layoutConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: layoutConfiguration)
    }
}

extension MainViewController  {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewType = ViewType.get(ofIndex: indexPath.row) else {
            return
        }
        
        if type(of: viewType.toViewController) == UIHostingController<NavigationTestView>.self {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }

        self.navigationController?.pushViewController(viewType.toViewController, animated: false)
    }
    
    
}
