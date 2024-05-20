//
//  TabCell.swift
//  StudyiOS
//
//  Created by nylah.j on 1/30/24.
//

import UIKit

struct MyCollectionModel {
    let title: Int
}

class MyCollectionViewCell: UICollectionViewCell {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var model: MyCollectionModel? { didSet { bind() } }

    lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange.withAlphaComponent(0.5)
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

    override var isSelected: Bool {
        didSet {
            contentsView.backgroundColor = isSelected ? .orange : .orange.withAlphaComponent(0.5)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
        addSubview(contentsView)
        contentsView.addSubview(titleLabel)
    }

    private func configure() {
        backgroundColor = .brown
        
        NSLayoutConstraint.activate([
            contentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: -20),
            contentsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            contentsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentsView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    private func bind() {
        titleLabel.text = "\((model?.title ?? 0))"
    }
}
