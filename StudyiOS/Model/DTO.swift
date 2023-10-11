//
//  DTO.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/10.
//

import Foundation

typealias UnknownCaseCodable = Codable & UnknownCaseDecodable

protocol UnknownCaseDecodable: Decodable where Self: RawRepresentable, Self.RawValue: Decodable { }

extension KeyedDecodingContainer {
    func decodeIfPresent<T: UnknownCaseDecodable>(_ type: T.Type, forKey key: K) throws -> T? {
        try? decode(T.self, forKey: key)
    }
    
    func decodeIfPresent<T: UnknownCaseDecodable>(_ types: Array<T>.Type, forKey key: K) throws -> [T]? {
        try? decode([T.RawValue?].self, forKey: key)
            .compactMap({ $0 })
            .compactMap({ T(rawValue: $0) })
    }
}




struct MenuListDTO: Codable, Equatable {
    let menuList: [MenuDTO]
    
    static var forTest: MenuListDTO {
        let subTabDTO: SubtabDTO = .init(id: -1,
                                         title: "subTab test title", type: .landing, assetProperty: .init(subtabBackgroundImage: .init(path: "", width: 100, height: 100), subtabTextImage: .init(path: "", width: 100, height: 100)), backgroundImage: "", textImage: "", landingType: .entireGenre, categoryTypeList: [.comic], mature: false, defaultCategoryType: .comic, defaultGenreType: .action)
        let menuDTO: MenuDTO = .init(id: -1, title: "menu test title", subtabList: [subTabDTO], menuOrder: 10)
        return .init(menuList: [menuDTO])
    }
}

struct MenuDTO: Codable, Equatable {
    let id: Int
    let title: String
    let subtabList: [SubtabDTO]
    let menuOrder: Int?
}

struct SubtabDTO: Codable, Equatable {
    let id: Int // 서브탭 ID
    let title: String // 서브탭 타이틀
    let type: SubtabType? // SECTION/LANDING
    let assetProperty: SubTabAssetProperty
    let backgroundImage: String? // 서브탭 메뉴 > 백그라운드
    let textImage: String? // 서브탭 메뉴 > 텍스트 이미지
    let landingType: StaticLandingType? // 고정형 랜딩타입
    
    let categoryTypeList: [CategoryType]?
    let mature: Bool? // 성인 서브탭 여부
    
    let defaultCategoryType: CategoryType? // 고정형 랜딩시 카테고리 타입
    let defaultGenreType: GenreType?
}

enum SubtabType: String, UnknownCaseCodable, Equatable{
    case section = "SECTION" // 서브탭 > 섹션 타입
    case landing = "LANDING" // 서브탭 > 고정형 랜딩 타입
    
    init(from decoder: Decoder) {
        self = (try? SubtabType(rawValue: decoder.singleValueContainer().decode(RawValue.self))) ?? .section
    }
}


struct SubTabAssetProperty: Codable, Hashable, Equatable {
    let subtabBackgroundImage: ImageProperty
    let subtabTextImage: ImageProperty
}

struct ImageProperty: Codable, Hashable, Equatable {
    let path: String
    let width: Int?
    let height: Int?
}

enum StaticLandingType: String, UnknownCaseCodable, Equatable {
    case entireGenre = "ENTIRE_GENRE"
    case subtabRanking = "SUBTAB_RANKING"
    case newRelease = "NEW_RELEASE"
    case freeToRead = "FREE_TO_READ"
    case original = "ORIGINAL"
    case ranking = "RANKING"
    case ongoing = "ON_GOING"
}

enum CategoryType: String, UnknownCaseCodable, Equatable {
    case comic = "COMIC"
    case novel = "NOVEL"
    case matureComic = "MATURE_COMIC"
    case matureNovel = "MATURE_NOVEL"
    case communityComic = "COMMUNITY_COMIC"
    case communityNovel = "COMMUNITY_NOVEL"
}

enum GenreType: String, UnknownCaseCodable, Equatable {
    case fantasy = "FANTASY"
    case romance = "ROMANCE"
    case romanceFantasy = "ROMANCE_FANTASY"
    case action = "ACTION"
    case actionFantasy = "ACTION_FANTASY"
    case drama = "DRAMA"
    case bl = "BL"
    case gl = "GL"
    case lgbtq = "LGBTQ"
    case comedy = "COMEDY"
    case sliceOfLife = "SLICE_OF_LIFE"
    case mystery = "MYSTERY"
    case sf = "SCIENCE_FICTION"
    case gaming = "GAMING"
    case horror = "THRILLER_HORROR"
    case nonFiction = "NON_FICTION"
}
