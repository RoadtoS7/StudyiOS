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

    private func makeStoreDescription(url: URL) -> NSPersistentStoreDescription {
        let persistentStoreDescription = NSPersistentStoreDescription(url: url)
        persistentStoreDescription.shouldInferMappingModelAutomatically = false
        persistentStoreDescription.shouldMigrateStoreAutomatically = false
        return persistentStoreDescription
    }

    func test_마이그레이션_이후에_기존의_container에_접근가능하며_데이터도_삭제_가능하다() throws {
        // given
        let v1Model: NSManagedObjectModel = CoreData.versionModel(versionName: "MenuLayout_ 3")
        let persistentStoreDescription = NSPersistentStoreDescription(url: storeURL)
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
        let (toURL, destinationName): (URL?, String) = migrationManager.performMigration(storeURL: storeURL, storeModel: v1Model, destinationModel: CoreData.latestVersionModel)
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
        
        
        // 새로운 persistent container를 로딩하는 방식
        
        let v2Container = NSPersistentContainer(name: "v2", managedObjectModel: CoreData.latestVersionModel)
        v2Container.persistentStoreDescriptions = [v2StoreDescription]
        
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
        v2Container.loadPersistentStores { description, error in
            XCTAssertNil(error)
            XCTAssertNotNil(description.url)
            XCTAssertEqual(description.url, toURL!)
            
            let v2Persons = try? getPersons(in: v2Container.viewContext)
            XCTAssertEqual(v2Persons!.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 마이그레이션 과정에서 해당 데이터를 인식하지 못하게 되기 때문이다.
    /// Entity를 제거 후에 마이그레이션을 할 때는, 데이터 제거 후에 마이그레이션을 해야 한다.
    func test_마이그레이션_이후에_기존의_conatiner의_데이터를_제거해도_이후버전에는_데이터가_남아있는다() throws {
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
        let object2 = insertMenuLayout(key: .mainHome, value: testMenuListJson, context: container.viewContext)
        let person1 = insertPerson(id: 0, name: "name", context: container.viewContext)
        let person2 = insertPerson(id: 1, name: "this is name", context: container.viewContext)
        try container.viewContext.save()
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "MenuLayout")
        let count = try container.viewContext.count(for: fetchRequest)
        XCTAssertEqual(count, 2)
        
        let personFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Person")
        let personCount = try container.viewContext.count(for: personFetchRequest)
        XCTAssertEqual(personCount, 2)
        
        // when
        let (toURL, destinationName): (URL?, String) = migrationManager.performMigration(storeURL: storeURL, storeModel: v1Model, destinationModel: CoreData.latestVersionModel)
        XCTAssertNotNil(toURL)
        let v1AttrsBeforeDeleteMenu = try FileManager.default.attributesOfItem(atPath: toURL!.path)
        let v1SizeContainingMenu = v1AttrsBeforeDeleteMenu[.size] as! Int
    
        
        // 마이그레이션 이후에 기존 데이터 제거
        container.viewContext.delete(object)
        container.viewContext.delete(person1)
        
        let newFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "MenuLayout")
        let newCount: Int = try container.viewContext.count(for: newFetchRequest)
        XCTAssertEqual(newCount, 1)
        
        let newPersonFetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Person")
        let newPersonCount: Int = try container.viewContext.count(for: newPersonFetchRequest)
        XCTAssertEqual(newPersonCount, 1)
        
        
        // then
        let v2StoreDescription = NSPersistentStoreDescription(url: toURL!)
        v2StoreDescription.shouldInferMappingModelAutomatically = false
        v2StoreDescription.shouldMigrateStoreAutomatically = false
        
        
        // 새로운 persistent container를 로딩하는 방식
        let v2Container = NSPersistentContainer(name: "App Container", managedObjectModel: CoreData.latestVersionModel)
        v2Container.persistentStoreDescriptions = [v2StoreDescription]
        
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
        v2Container.loadPersistentStores { description, error in
            XCTAssertNil(error)
            XCTAssertNotNil(description.url)
            XCTAssertEqual(description.url, toURL!)
            
            let v2Persons = try? getPersons(in: v2Container.viewContext)
            XCTAssertEqual(v2Persons!.count, 2)
            expectation.fulfill()
        }
        
        // version 3 모델로 다시 마이그레이션
        let version3Model = CoreData.versionModel(versionName: "MenuLayout_ 3")
    
        let (destURL, destName): (URL?, String) = migrationManager.performMigration(storeURL: toURL!,
                                                                                    storeModel: CoreData.latestVersionModel,
                                                                                    destinationModel: version3Model)
        guard let destURL else {
            XCTFail("마이그레이션 실패")
            return
        }
                                                                                                                                
        let exp = XCTestExpectation()
        
        let description = makeStoreDescription(url: destURL)
        let newContainer = NSPersistentContainer(name: "App Container", managedObjectModel: version3Model)
        newContainer.persistentStoreDescriptions = [description]
        
        newContainer
            .loadPersistentStores { description, error in
                XCTAssertNil(error)
                XCTAssertNotNil(description.url)
                XCTAssertEqual(description.url, destURL)
                
                let v2Persons = try? getPersons(in: newContainer.viewContext)
                XCTAssertEqual(v2Persons!.count, 2)
                
                let newMenus = try? getMenuLayouts(in: newContainer.viewContext)
                
                // 최신 버전으로 마이그레이션 하는 과정에서 Menu 데이터를 인식하지 못하게 되기 때문에, version 3로 메뉴데이터를 가지고 오지 못함
                XCTAssertEqual(newMenus?.count, 0)
                exp.fulfill()
            }
        
        let v3Attrs = try FileManager.default.attributesOfItem(atPath: destURL.path)
        let v3Size = v3Attrs[.size] as! Int
        
        XCTAssertNotEqual(v1SizeContainingMenu, .zero)
        XCTAssertEqual(v1SizeContainingMenu, v3Size)
        
        wait(for: [expectation, exp], timeout: 5)
    }
    
    func test_entity구성이_같으면_version_hash가_같아서_같은버전으로_취급되고_마이그레이션도_불가능하다() {
        let v2 = CoreData.versionModel(versionName: "MenuLayout_2")
        let v4 = CoreData.versionModel(versionName: "MenuLayout_ 4")
        let v2PersonId = v2.entityVersionHashesByName["Person"]
        let v4PersonId = v4.entityVersionHashesByName["Person"]
        
        let persistentStoreDescription = NSPersistentStoreDescription(url: storeURL)
        persistentStoreDescription.shouldInferMappingModelAutomatically = false
        persistentStoreDescription.shouldMigrateStoreAutomatically = false
        
        let container = NSPersistentContainer(name: "App Container", managedObjectModel: v2)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { description, error in
            XCTAssertNil(error)
            XCTAssertEqual(description.url, self.storeURL)
        }
        
        let (destURL, _) = migrationManager.performMigration(storeURL: storeURL, storeModel: v2, destinationModel: v4)
        XCTAssertNil(destURL, "같은 버전으로 취급되기 때문에 마이그레이션도 불가능하다")
        
        XCTAssertNotNil(v2PersonId)
        XCTAssertNotNil(v4PersonId)
        XCTAssertEqual(v2PersonId, v4PersonId)
    }
}

