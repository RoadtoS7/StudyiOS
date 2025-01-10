//
//  CollectionViewController+DataSource.swift
//  StudyiOS
//
//  Created by 김수현 on 9/8/24.
//

import UIKit

final class CollectionViewController2: UIViewController {
    let cellReuseId: String = String(describing: FlowLayoutCell.self)
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
        
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: cellReuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CollectionViewController2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as? UICollectionViewListCell else {
            return UICollectionViewCell()
        }
        
        var config = cell.defaultContentConfiguration()
        let text = "\(indexPath.section) - \(indexPath.row) - \(indexPath.item)"
        config.text = text
        cell.contentConfiguration = config
        print("$$ cellForItem: ", text)
        return cell
    }
}

extension CollectionViewController2: UICollectionViewDelegate {
    
}

final class FlowLayoutCell: UICollectionViewListCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        print("$$ prepareForReuse")
    }
}
