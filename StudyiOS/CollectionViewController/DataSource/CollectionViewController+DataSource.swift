//
//  CollectionViewController+DataSource.swift
//  StudyiOS
//
//  Created by 김수현 on 9/8/24.
//

import UIKit

final class CollectionViewController2: UIViewController {
    let cellReuseId: String = String(describing: UICollectionViewListCell.self)
    private let flowLayout: UICollectionViewFlowLayout = {
        $0.itemSize = .init(width: 100, height: 100)
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: cellReuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionViewController2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as? UICollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        var config = cell.defaultContentConfiguration()
        config.text = "\(indexPath.section) - \(indexPath.row) - \(indexPath.item)"
        cell.contentConfiguration = config
        return cell
    }
}

extension CollectionViewController2: UICollectionViewDelegate {
    
}

