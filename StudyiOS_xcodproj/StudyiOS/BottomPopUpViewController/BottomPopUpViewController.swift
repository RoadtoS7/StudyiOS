//
//  BottomPopUpViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/26.
//

import UIKit

enum Constant {
    static let titleText = "%@ 이용권이 필요합니다.\n대여하고 바로 이어보시겠습니까?"
}
class BottomPopUpViewController: UIViewController {
    private var popUpView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private var splitLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .white
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return line
    }()
    
    private lazy var holdingCash: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(holdingCashTitleLabel)
        stackView.addArrangedSubview(holdingCashLabel)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var holdingCashTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 보유한 캐시"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var holdingCashLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var priceTag: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(priceTagTitleLabel)
        stackView.addArrangedSubview(priceTagLabel)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var priceTagTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대여권(3일)"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceTagLabel: UILabel = {
        let label = UILabel()
        label.text = "300원"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private var showOtherOptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("다른 구매 옵션 보기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.addArrangedSubview(titleLable)
        view.addArrangedSubview(descriptionLabel)
        view.addArrangedSubview(splitLine)
        view.addArrangedSubview(holdingCash)
        view.addArrangedSubview(priceTag)
        view.addArrangedSubview(buttonStackView)
        view.addArrangedSubview(showOtherOptionButton)
        
        view.setCustomSpacing(24, after: descriptionLabel)
        view.setCustomSpacing(24, after: splitLine)
        view.setCustomSpacing(16, after: holdingCash)
        view.setCustomSpacing(34, after: priceTag)
        view.setCustomSpacing(20, after: buttonStackView)
        
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins.top = 20
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
        view.axis = .horizontal
        view.backgroundColor = .clear
        view.distribution = .fillEqually
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.alignment = .fill
        view.addArrangedSubview(leftButton)
        view.addArrangedSubview(rightButton)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(popUpView)
        view.addSubview(contentView)
        
//        let defaultHeightConstraint = popUpView.heightAnchor.constraint(equalToConstant: 100)
//        defaultHeightConstraint.priority = .defaultHigh
        
        
        NSLayoutConstraint.activate([
            popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: popUpView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor)
        ])
        
        var visibleTitle = titleLable.text
        let dots = ".."
    
        while contentSize(of: titleLable) > view.frame.width - 40 {
            print("contentSize: \(contentSize(of: titleLable))")
            visibleTitle?.removeLast()
            setTextTitleLabel(text: visibleTitle! + dots)
        }
        
    }
    
    func contentSize(of view: UIView) -> CGFloat {
        view.intrinsicContentSize.width
    }
    
    func setTextTitleLabel(text: String) {
        let text = String.init(format: Constant.titleText, text)
        titleLable.text = text
    }
}

extension BottomPopUpViewController {
    static func create(title: String, description: String?) -> BottomPopUpViewController {
        let popUp = BottomPopUpViewController()
        popUp.titleLable.text = String.init(format: Constant.titleText, title)
        
        print("popUpTitle contentSize: \(popUp.titleLable.intrinsicContentSize.width)")
        popUp.descriptionLabel.text = description
        return popUp
    }
}
