//
//  CollectionViewController+DataSource.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/07/07.
//

import UIKit

extension CollectionViewController {
    // UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>
    // UICollectionviewDataSource: 프로토콜, CollectionView의 DataSource가 가져야 하는 것들을 정의
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    
    // NSDiffableDataSourceSnapShot <SectionIdentifierType, ItemIdentiferType>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    // DataSource에서 하는 동작은 별도의 파일로 분리해낸 것이다.
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        // cell.defaultContentConfiguration = 시스템에 설정된 default 스타일에 따른 cell configuration
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
}
