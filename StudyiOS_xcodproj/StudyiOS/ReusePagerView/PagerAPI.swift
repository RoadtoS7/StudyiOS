//
//  API.swift
//  StudyiOS
//
//  Created by nylah.j on 2/5/24.
//

import Foundation
import UIKit
import Combine
import OSLog

typealias MainHomeSection = MainHomeData.RawData.Section
typealias Card = MainHomeData.RawData.Section.CardGroup.Card

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

func logError(message: String) {
    os_log(.error, log: .error, "%@", message)
}

// MARK: - Asset
struct Asset {
    static let likeOnImage = UIImage(named: "like_on")!
    static let likeOffImage = UIImage(named: "like_off")!
}


// MARK: - PagerApiRequest
struct PagerApiRequest {
    static func getMainHomeListData(completion: @escaping (MainHomeData?) -> Void) {
        let urlString = "https://gateway-kw-qa.kakao.com/section/v1/view/bundles?tag=top_romance_fantasy_featured"
        guard let url = URL(string: urlString) else { return }
        request(MainHomeData.self, url: url) { data in
            completion(data)
        }
    }
    
    static func getMainHomeListData() async -> MainHomeData? {
        let urlString = "https://gateway-kw-qa.kakao.com/section/v1/view/bundles?tag=top_romance_fantasy_featured"
        guard let url = URL(string: urlString) else { return nil }
        return await request(MainHomeData.self, url: url)
    }
    
    static func getContentHomeData(contentId: Int, completion: @escaping (ContentHomeData?) -> Void) {
        let urlString = "https://gateway-kw-qa.kakao.com/decorator/v2/decorator/contents/\(contentId)/profile"
        guard let url = URL(string: urlString) else { return }
        request(ContentHomeData.self, url: url) { data in
            completion(data)
        }
    }
    
    static private func request<T: Decodable>(_ type: T.Type, url: URL, completion: @escaping (T?)->Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                  let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject),
                  let result = try? JSONDecoder().decode(T.self, from: jsonData) else {
                completion(nil)
                return
            }
            completion(result)
        }
        task.resume()
    }
    
    static private func request<T: Decodable>(_ type: T.Type, url: URL) async -> T? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
        }
        catch {
            logError(message: "$$ error \(error)")
            return nil
        }
    }
}

// MARK: - test 용 api
func apiTest() {
    // 메인홈 데이터
    PagerApiRequest.getMainHomeListData() { result in
        let sectionIds = result?.data.sections.map({
            $0.id
        })
        let modules = result?.data.sections.map { Module(rawValue: $0.module ) ?? .other }
        logError(message: "$$ modules, \(modules)")
    }
    
    // 작품홈 데이터 (필요시 사용)
    PagerApiRequest.getContentHomeData(contentId: 3346) { result in
        print(result?.data.id ?? 0)
    }
}

struct WebtoonCardGroup {
    let cards: [Content]
}


protocol WebtoonSectionPresentable {
    var title: String { get }
    var module: Module { get }
    var card: WebtoonCardGroup { get }
}

struct WebtoonSection: WebtoonSectionPresentable {
    let title: String
    let module: Module
    let card: WebtoonCardGroup
}


struct EmptySection: WebtoonSectionPresentable {
    let title: String = ""
    let module: Module = .empty
    let card: WebtoonCardGroup = .init(cards: [])
}

enum Module: String {
    case main = "MAIN"
    case gridGeneral = "GRID_GENERAL_6"
    case gridAnchor = "GRID_ANCHOR_7"
    case empty
    case other
    // RANK, GIDAMOO_PLUS_HOT, TODAY_FREE_PUBLISH ... 별도 타입 정의하지 않음. (other 로 처리)
}


// MARK: - Data Model
struct MainHomeData: Codable {
    let data: RawData
    
    struct RawData: Codable {
        let sections: [Section]
        
        struct Section: Codable {
            let id: String
            let title: String
            let module: String
            let cardGroups: [CardGroup]
            
            struct CardGroup: Codable {
                let cards: [Card]?
                
                struct Card: Codable, Hashable {
                    let id: String
                    let content: Content
                }
            }
        }
    }
}

extension MainHomeData {
    func convertToDomain() -> [WebtoonSection] {
        let sections = data.sections
        let webtoonSections: [WebtoonSection] = sections.map { section in
            convertToDomain(section: section)
        }
        return webtoonSections
    }
    
    private func convertToDomain(section: RawData.Section) -> WebtoonSection {
        let title = section.title
        let module = Module(rawValue: section.module) ?? .other
        let cardGroup: WebtoonCardGroup = convertToDomain(cardGroups: section.cardGroups)
        return WebtoonSection(title: title, module: module, card: cardGroup)
    }
    
    
//    private func convertWebtoonCardToRankCellType(index: Int, card: WebtoonCardItem, with section: WebtoonSection) -> MainTopRankCellType {
//        switch section.module?.moduleType {
//        case .main:
//            return .operationBig
//        case .gridGeneral:
//            return card.additional?.landingType == .event ? .operationSmallEvent : .operationSmallContent
//        default:
//            if let label = card.additional?.label, let ranking = Int(label) {
//                return ranking == 1 ? .cardBig : .cardSmall
//            } else {
//                return index == 0 ? .cardBig : .cardSmall
//            }
//        }
//    }
    
    private func convertToDomain(cardGroups: [RawData.Section.CardGroup]) -> WebtoonCardGroup {
        let cards: [Content] = (cardGroups.first?.cards ?? [])
            .map({ card in
                card.content
            })
        return WebtoonCardGroup(cards: cards)
    }
}

//extension Section {
//    init(title: String, module: Module, cards: [Card]) {
//        self.title = title
//        self.module = module.rawValue
//        self.cardGroups = [
//            .init(cards: cards)
//        ]
//    }
//}

struct ContentHomeData: Codable {
    let data: RawData
    
    struct RawData: Codable {
        /// 작품 id.
        let id: Int
        let title: String
        let recommendations: [Recommendation]
        
        struct Recommendation: Codable {
            let id: String
            let title: String
            let contents: [Content]
        }
    }
}

struct Content: Codable, Hashable {
    /// 작품 id.
    let id: Int
    /// 작품 제목.
    let title: String
    
    let backgroundImage: String
    var backgroundImageURL: URL? {
        URL(string: backgroundImage + ".jpg")
    }
    
    let featuredCharacterImageB: String
    var characterImageBURL: URL? {
        URL(string: featuredCharacterImageB + ".png")
    }
    
    let featuredCharacterImageA: String
    var characterImageAURL: URL? {
        URL(string: featuredCharacterImageA + ".png")
    }
    
    let titleImageB: String
    var titleImageURL: URL? {
        URL(string: titleImageB + ".png")
    }
}

// MARK: - For Preview
extension Content {
    init(id: Int, title: String, titleImageB: String = "https://kr-a.kakaopagecdn.com/QA/C/3356/t1/2x/1205b05d-5555-4ecb-bb82-06e6b976dfb4.png", backgroundImage: String, characterImageA: String, charaterImageB: String) {
        self.id = id
        self.title = title
        self.titleImageB = title
        self.backgroundImage = backgroundImage
        self.featuredCharacterImageA = characterImageA
        self.featuredCharacterImageB = charaterImageB
    }
}
