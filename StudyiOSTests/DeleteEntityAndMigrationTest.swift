//
//  DeleteEntityAndMigrationTest.swift
//  StudyiOSTests
//
//  Created by nylah.j on 2023/10/13.
//

import XCTest
@testable import StudyiOS
import CoreData

class DeleteEntityAndMigrationTest: XCTestCase {
    let migrationManager = MigrationManager()
    let jsonLoader = JsonLoader()
    var testMenuListJson: String!
    var testMenuListDTO: MenuListDTO!
    var testMenuListData: Data!
    var storeURL: URL!
 
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
        
        storeURL = makeTemporaryStoreURL()
    }

    override func tearDownWithError() throws {
        try FileManager.default.removeItem(at: storeURL)
    }
    
    private func makeStoreDescription(url: URL) -> NSPersistentStoreDescription {
        let persistentStoreDescription = NSPersistentStoreDescription(url: url)
        persistentStoreDescription.shouldInferMappingModelAutomatically = false
        persistentStoreDescription.shouldMigrateStoreAutomatically = false
    }

    func test_마이그레이션_이후에_기존의_container에_접근가능하며_데이터도_삭제_가능하다() throws {
        // given
        let v1Model: NSManagedObjectModel = CoreData.versionModel(versionName: "MenuLayout_ 3")
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.url = storeURL
        persistentStoreDescription.shouldInferMappingModelAutomatically = false
        persistentStoreDescription.shouldMigrateStoreAutomatically = false
        
        let container = NSPersistentContainer(name: "App Container", managedObjectModel: v1Model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
        
        let object = insertMenuLayout(key: .mainHome, value: testMenuListJson, context: container.viewContext)
        let person1 = insertPerson(id: 0, name: "name", context: container.viewContext)
        let person2 = insertPerson(id: 1, name: "this is name", context: container.viewContext)
        try container.viewContext.save()
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "MenuLayout")
        let count = try container.viewContext.count(for: fetchRequest)
        XCTAssertEqual(count, 1)
        
        let personFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Person")
        let personCount = try container.viewContext.count(for: personFetchRequest)
        XCTAssertEqual(personCount, 2)
        
        // when
        let (toURL, destinationName): (URL?, String) = migrationManager.performMigration(storeURL: storeURL, storeModel: v1Model)
        XCTAssertNotNil(toURL)
        
        // 마이그레이션 이후에 기존 데이터 제거
        container.viewContext.delete(object)
        container.viewContext.delete(person1)
        
        let newFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "MenuLayout")
        let newCount: Int = try container.viewContext.count(for: newFetchRequest)
        XCTAssertEqual(newCount, Int.zero)
        
        let newPersonFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Person")
        let newPersonCount: Int = try container.viewContext.count(for: newPersonFetchRequest)
        XCTAssertEqual(newPersonCount, 1)
        
        
        // then
        let v2StoreDescription = NSPersistentStoreDescription(url: toURL!)
        v2StoreDescription.shouldInferMappingModelAutomatically = false
        v2StoreDescription.shouldMigrateStoreAutomatically = false
        
        let expectation2 = XCTestExpectation(description: "Open a file asynchronously.")
        container.persistentStoreCoordinator.addPersistentStore(with: v2StoreDescription) { description, error in
            XCTAssertNil(error)
            XCTAssertNotNil(description.url) // 사용하는 sqlite 파일이 같다.
            XCTAssertEqual(description.url, toURL!)
            
            let v1Persons = try? getPersons(in: container.viewContext)
            XCTAssertEqual(v1Persons!.count, 1)
            expectation2.fulfill()
        }
        
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: CoreData.latestVersionModel)
        
        let v2Container = NSPersistentContainer(name: "destinationName", managedObjectModel: CoreData.latestVersionModel)
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
        v2Container.loadPersistentStores { description, error in
            XCTAssertNil(error)
            XCTAssertNotNil(description.url)
            XCTAssertEqual(description.url, toURL!) // 사용하는 sqlite 파일이 다르다.
            
            let v2Persons = try? getPersons(in: v2Container.viewContext)
            XCTAssertEqual(v2Persons!.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation, expectation2], timeout: 3)
    }
    
    func test_마이그레이션_이후에_기존의_conatiner의_데이터제거하면_데이터가_남아있는_것_아닌가() throws {
        makeStoreDescription(url: storeURL)
    }
}

