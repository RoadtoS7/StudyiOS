//
//  ViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import UIKit

class MainViewController: UIViewController {
    let collectionView: UICollectionView = {
        let view = UICollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionViewLayout = Layout
        return view
    }()
    
    let button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        // Do any additional setup after loading the view.
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

