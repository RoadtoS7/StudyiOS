//
//  PageViewcontroller.swift
//  StudyiOS
//
//  Created by nylah.j on 2/5/24.
//

import UIKit
import Combine

protocol ReusePagerView: AnyObject {
    func updateData(_ models: [Card])
}

struct CellModel: Hashable {
    let id: Int
    let title: String
    let image: String
}

class PageViewCardCell: UICollectionViewCell {
    private var titleView: UILabel!
    private var imageView: UIImageView!
    private var imageLoadingTask: (Task<(), Never>)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
        titleView.text = ""
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        let titleView: UILabel = .init()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.titleView = titleView
        
        
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    func apply(cellModel: Card) {
        titleView.text = cellModel.content.title
        
        guard let url = URL(string: cellModel.content.backgroundImage + ".heic") else { return }
        self.imageLoadingTask = Task {
            let request: URLRequest = .init(url: url)
            let (data, _) = (try? await URLSession.shared.data(for: request)) ?? (nil, nil)
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            imageView.image = image
        }
    }
}

class CardGridView: UIView {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Card>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Card>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCollectionView() {
        let layout = createBasicGridLayout()
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let cellRegistration: UICollectionView.CellRegistration<PageViewCardCell, Card> = .init { cell, indexPath, itemIdentifier in
            cell.apply(cellModel: itemIdentifier)
        }
        
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.apply(cellModel: itemIdentifier)
            return cell
        })
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    private func createBasicGridLayout() -> UICollectionViewLayout {
        let screenWidth: CGFloat = self.bounds.width
        let mok: CGFloat = screenWidth / 3
        let namujee: CGFloat = (screenWidth - mok * 3) / 2
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(mok),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(360))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(namujee)
      
        let section = NSCollectionLayoutSection(group: group)


        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    public func updateData(_ models: [Card]) {
        var snapShot = dataSource.snapshot()
        if snapShot.indexOfSection(0) == nil {
            snapShot.appendSections([0])
        }
        
        snapShot.appendItems(models)
        dataSource.apply(snapShot)
    }
}


class PageViewcontroller: UIViewController, ReusePagerView {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Card>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Card>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = createBasicGridLayout()
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let cellRegistration: UICollectionView.CellRegistration<PageViewCardCell, Card> = .init { cell, indexPath, itemIdentifier in
            cell.apply(cellModel: itemIdentifier)
        }
        
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.apply(cellModel: itemIdentifier)
            return cell
        })
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("$$ viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("$$ viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("$$ viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("$$ viewDidDisappear")
    }
    
    private func createBasicGridLayout() -> UICollectionViewLayout {
        let screenWidth: CGFloat = view.bounds.width
        let mok: CGFloat = screenWidth / 3
        let namujee: CGFloat = (screenWidth - mok * 3) / 2
    
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(mok),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(360))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(namujee)
      
        let section = NSCollectionLayoutSection(group: group)


        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    public func updateData(_ models: [Card]) {
        var snapShot = dataSource.snapshot()
        if snapShot.indexOfSection(0) == nil {
            snapShot.appendSections([0])
        }
        
        snapShot.appendItems(models)
        dataSource.apply(snapShot)
    }
}
