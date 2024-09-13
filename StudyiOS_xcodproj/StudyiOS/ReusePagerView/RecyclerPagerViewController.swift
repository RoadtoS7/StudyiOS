//
//  PagerViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2/5/24.
//

import UIKit


class SubPageViewCell: UICollectionViewCell {
    
    
    private var cardGridView: CardGridView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func initLayout() {
        cardGridView = .init(frame: self.bounds)
        cardGridView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(cardGridView)
    }
    
    func updateCards(_ cards: [Card]) {
        cardGridView.updateData(cards)
    }
}


class PageViewCell<VC: PageViewcontroller>: UICollectionViewCell {
    var pageViewController: VC?
    weak var parentViewController: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializePageViewController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializePageViewController() {
        let pageVC = VC()

        self.contentView.addSubview(pageVC.view)
        pageVC.view.frame = self.bounds
        pageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.pageViewController = pageVC
    }
    
    func addToParentViewController(_ parentViewController: UIViewController) {
        guard let pageViewController = self.pageViewController else { return }

        if pageViewController.parent != parentViewController {
            parentViewController.addChild(pageViewController)
            pageViewController.didMove(toParent: parentViewController)
            self.parentViewController = parentViewController
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO:  셀 재사용 준비
            
    }
    
    func updateData(newData: [Card]) {
        pageViewController?.updateData(newData)
    }
}

struct Page {
    let cards: [Card]
}

class PagerViewController: UIViewController {
    var collectionView: UICollectionView!
    var pages: [Page] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        
        PagerApiRequest.getMainHomeListData { [weak self] mainHomeData in
            guard let mainHomeData = mainHomeData else { return }
            let sections = mainHomeData.data.sections
            let pages = sections.compactMap { $0.cardGroups.first?.cards }.map {
                Page(cards: $0)
            }
                    
            self?.pages = pages

            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func initLayout() {
        addSubView()
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addSubView() {
        initCollectionView()
        view.addSubview(collectionView)
    }
    
    private func initCollectionView() {
        let flowLayout: UICollectionViewLayout = {
            let flowLayout: UICollectionViewFlowLayout = .init()
            flowLayout.itemSize = .init(width: view.bounds.width, height: view.bounds.height)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = .zero
            flowLayout.minimumInteritemSpacing = .zero
            return flowLayout
        }()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        
        collectionView.register(SubPageViewCell.self, forCellWithReuseIdentifier: SubPageViewCell.reuseIdentifier)
        self.collectionView = collectionView
    }
}

extension PagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageViewCell.reuseIdentifier, for: indexPath) as? PageViewCell else {
            return UICollectionViewCell()
        }
        cell.addToParentViewController(self)
        let index = indexPath.item
        cell.updateData(newData: pages[index].cards)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
