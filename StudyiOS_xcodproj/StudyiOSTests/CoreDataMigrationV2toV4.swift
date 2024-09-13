//
//  CoreDataMigrationV2toV4.swift
//  StudyiOSTests
//
//  Created by nylah.j on 2023/10/11.
//

import XCTest
@testable import StudyiOS
import CoreData

final class CoreDataMigrationV2toV4: XCTestCase {
    let coreDataAdapter: CoreDataAdapter = .init()
    let jsonLoader = JsonLoader()
    var testMenuListJson: String!
    var testMenuListDTO: MenuListDTO!
    var testMenuListData: Data!

    override func setUpWithError() throws {
        let json: String = jsonLoader.loadLayoutJson()
        
        guard let data = json.data(using: .utf8),
            let menuListDTO: MenuListDTO? = data.decode() else {
            XCTFail("testMenuListDTO not exist")
            return
        }
        
        testMenuListJson = json
        testMenuListData = data
        testMenuListDTO = menuListDTO
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_MenuLayout이_없는_버전1에서_동일하게_MenuLayout이_없는_버전3로_마이그레이션_테스트() throws {
        // given
        let v2Container = try startPersistentContainer("MenuLayout_2")
        
        let oldId: Int64 = 5
        let oldName: String = "StudyiOS"
        insertPerson(id: oldId, name: oldName, context: v2Container.viewContext)
        
        try v2Container.viewContext.save()
        
        
        // when
        let v4Container = try migrate(container: v2Container, to: "MenuLayout_ 4")
        
        let personFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let persons: [NSFetchRequestResult] = try v4Container.viewContext.fetch(personFetchRequest)
        XCTAssertEqual(persons.count, 1)
        
        let person: NSManagedObject = persons.first as! NSManagedObject
        let newId: Int64 = person.value(forKey: "id") as! Int64
        let newName: String = person.value(forKey: "name") as! String
        XCTAssertEqual(oldId, newId)
        XCTAssertEqual(oldName, newName)
    }
}
