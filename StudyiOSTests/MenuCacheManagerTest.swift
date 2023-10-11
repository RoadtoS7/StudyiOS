//
//  MenuCacheManagerTest.swift
//  StudyiOSTests
//
//  Created by nylah.j on 2023/10/06.
//

import XCTest
@testable import StudyiOS


final class MenuCacheManagerTest: XCTestCase {
    let manager = MenuCacheManager.shared
    var testJson: String!
    var testMenuListDTO: MenuListDTO!
    
    override func setUpWithError() throws {
        
        let jsonLoader = JsonLoader()
        let menuDTOJson: String = jsonLoader.loadLayoutJson()
        self.testJson = menuDTOJson
        
        guard let data = menuDTOJson.data(using: .utf8),
              let menuDto: MenuListDTO = decode(data: data) else {
            XCTFail("menuDto is nil")
            return
        }
        
        testMenuListDTO = menuDto
        manager.deleteAllCachedMenu()
    }

    override func tearDownWithError() throws {
        manager.deleteAllCachedMenu()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    
    func test_최초_캐싱_동작() {
        manager.cacheMenu(key: .mainHome, value: testMenuListDTO)
        
        let newMenuDTO: MenuListDTO? = manager.menuList(key: .mainHome)
        XCTAssertNotNil(newMenuDTO)
        XCTAssertEqual(testMenuListDTO, newMenuDTO)
    }
    
    func test_캐싱파일_변경동작() {
        // given
        manager.cacheMenu(key: .mainHome, value: testMenuListDTO)
        
        // when
        let newMenuDTO = MenuListDTO.forTest
        manager.cacheMenu(key: .mainHome, value: newMenuDTO)
        
        
        // then
        let menuDTOInCache: MenuListDTO? = manager.menuList(key: .mainHome)
        XCTAssertNotNil(menuDTOInCache)
        XCTAssertNotEqual(testMenuListDTO, menuDTOInCache)
        XCTAssertEqual(newMenuDTO, menuDTOInCache)
    }
    
   
}

extension MenuCacheManagerTest {
    func decode<CachedValue: Decodable>(data: Data) -> CachedValue? {
        let jsonDecoder = JSONDecoder()
        
        if let cachedValue = try? jsonDecoder.decode(CachedValue.self, from: data) {
            return cachedValue
        }
        return nil
    }
}
