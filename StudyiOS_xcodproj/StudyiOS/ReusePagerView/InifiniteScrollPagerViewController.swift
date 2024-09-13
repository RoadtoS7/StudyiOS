////
////  InifiniteScrollPagerViewController.swift
////  StudyiOS
////
////  Created by nylah.j on 1/30/24.
////
//
//import UIKit
//
//class InifiniteScrollPagerViewController: UIViewController {
//    
//    var dataSource: [MyCollectionModel] = []
//    
//    lazy var collectionView: UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = 12
//        flowLayout.scrollDirection = .horizontal
//        
//        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        view.backgroundColor = .lightGray
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    private func setupDataSource() {
//        for i in 0...10 {
//                    let model = MyCollectionViewModel(title: i)
//                    dataSource += [model]
//                }
//    }
//    
//    private func addSubviews() {
//        view.addSubview(collectionView)
//    }
//    
//    private func setupDelegate() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    
//    private func registerCell() {
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseIdentifier)
//    }
//    
//    // delegate
//    func didTapCell(at indexPath: IndexPath) {
//        // currentPage = indexPath.item
//    }
//}
//
//extension InfiniteScrollViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 60, height: collectionView.frame.height)
//    }
//}
