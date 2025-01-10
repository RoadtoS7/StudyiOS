////
////  CustomFlowLayoutCollectionViewController.swift
////  StudyiOS
////
////  Created by nylah.j on 2023/07/21.
////
//
//import UIKit
//
//class CustomFlowLayoutCollectionViewController: UIViewController {
//    let layout: CustomTabBarLayout = {
//        let layout: CustomTabBarLayout = .init()
//        layout.scrollDirection = .vertical
//        return layout
//    }()
//
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, Int>
//    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Int>
//
//    private lazy var collectionView: UICollectionView = .init(frame: view.bounds, collectionViewLayout: layout)
//    private var dataSource: DataSource!
//
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        view.addSubview(collectionView)
//
//
//
//        var snapShot: SnapShot = .init()
//        let identifiers = Array(1...10)
//        snapShot.appendItems(identifiers)
//        dataSource.apply(snapShot)
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func configureCell() {
//        let cellRegistraion: UICollectionView.CellRegistration = .init { cell, indexPath, itemIdentifier in
//            var contentConfiguration = cell.defaultContentConfiguration()
//
//              contentConfiguration.text = "\(itemIdentifier)"
//              contentConfiguration.textProperties.color = .lightGray
//
//              cell.contentConfiguration = contentConfiguration
//        }
//
//        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: itemIdentifier)
//        })
//    }
//}
//
//class TextCell: UICollectionViewCell {
//    let label: UILabel
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(label)
//    }
//}
