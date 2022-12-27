//
//  NestedGroupViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/10/02.
//

import UIKit

typealias RankingDataSource = UICollectionViewDiffableDataSource<RankingSection, Int>

enum RankingSection: Int {
    case rankOne = 0
    case rankTwoAndThree = 1
    case rankOther = 2
    
    var columnCount: Int {
        switch self {
        case .rankOne: return 1
        case .rankTwoAndThree: return 2
        case .rankOther: return 4
        }
    }
}

class NestedGroupViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: RankingDataSource!
    
    override func viewDidLoad() {
        initView()
        initDataSource()
    }
}

extension NestedGroupViewController {
    func initView() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: createLayout())
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    func initDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let rankingSection = RankingSection(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
            switch rankingSection {
            case .rankOne:
                return collectionView.dequeueReusableCell(withReuseIdentifier: RankOneCell.reuseIdentifier, for: indexPath)
            case .rankTwoAndThree:
                return collectionView.dequeueReusableCell(withReuseIdentifier: RankOneCell.reuseIdentifier, for: indexPath)
            case .rankOther:
                return collectionView.dequeueReusableCell(withReuseIdentifier: RankOtherCell.reuseIdentifier, for: indexPath)
            }
        })
    }

    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let rankingSection = RankingSection(rawValue: sectionIndex) else {
                return nil
            }
            
            let section: NSCollectionLayoutSection
            switch rankingSection {
            case .rankOne:
                let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
                let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
                let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(353))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = .init(group: group)
            case .rankTwoAndThree:
                let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1.0))
                let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
                let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(353))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = .init(group: group)
                section.interGroupSpacing = 4
            case .rankOther:
                let webtoonItemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
                let webtoonItem: NSCollectionLayoutItem = .init(layoutSize: webtoonItemSize)
                
                let webtoonItemGroupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(115))
                let webtoonItemGroup: NSCollectionLayoutGroup
                if #available(iOS 16.0, *) {
                    webtoonItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: webtoonItemGroupSize, repeatingSubitem: webtoonItem, count: 9)
                } else {
                    webtoonItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: webtoonItemGroupSize, subitem: webtoonItem, count: 9)
                }
                let adItemSize: NSCollectionLayoutSize = .init(widthDimension: .absolute(256), heightDimension: .absolute(65))
                let adItem: NSCollectionLayoutItem = .init(layoutSize: adItemSize)
                
                let nestedGroupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(115 * 3 + 4 * 3 + 65))
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [webtoonItemGroup, adItem])
                
                section = .init(group: nestedGroup)
            }
            return section
        }
        
        return .init(sectionProvider: sectionProvider)
    }
}



