//
//  SearchBarViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 1/10/25.
//

import Foundation
import UIKit

class BeforeSearchBarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let questionButton = UIBarButtonItem(title: "질문", style: .plain, target: self, action: #selector(questionButtonTapped))
        navigationItem.rightBarButtonItem = questionButton
    }
    
    @objc private func questionButtonTapped() {
        let searchBarViewController = SearchBarViewController()
        navigationController?.pushViewController(searchBarViewController, animated: true)
    }
}

class SearchBarViewController: UIViewController {
    private let searchBar: SearchBar = {
        let searchBar = SearchBar()
        return searchBar
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // UISearchBar에서 value(forKey: )를 통해서 UITextField를 얻어올 수 있다.
        let textField = searchBar.value(forKey: "searchField") as? UITextField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        
        
//        let cancelButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelSearchBar))
//        cancelButtonItem.tintColor = .green
//        navigationItem.rightBarButtonItem = cancelButtonItem
        
        // showsCancelButton
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    private func setUpSearchBarCancelButton() {
        
    }
    
    
    @objc private func cancelSearchBar() {
        searchBar.resetTextField()
    }
}
        
