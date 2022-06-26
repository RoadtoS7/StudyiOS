//
//  BottomPopUpViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/26.
//

import UIKit

class BottomPopUpViewController: UIViewController {
    private var popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    private var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var splitLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 44, green: 44, blue: 44)
        return view
    }()
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.addArrangedSubview(titleLable)
        view.addArrangedSubview(descriptionLabel)
        view.addArrangedSubview(splitLine)
        view.addArrangedSubview(buttonStackView)
        return view
    }()
    
    private var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setTitle("닫기", for: .normal)
        return button
    }()
    
    private var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("대여하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.addArrangedSubview(leftButton)
        view.addArrangedSubview(rightButton)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(popUpView)
        view.addSubview(contentView)
        view.addSubview(titleLable)
        view.addSubview(descriptionLabel)
        view.addSubview(splitLine)
        view.addSubview(buttonStackView)
        
        let defaultHeightConstraint = popUpView.heightAnchor.constraint(equalToConstant: 100)
        defaultHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            defaultHeightConstraint,
            
            contentView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: popUpView.topAnchor)
        ])
    }
}
