//
//  CoreDataTest.swift
//  StudyiOSTests
//
//  Created by nylah.j on 2023/10/10.
//

import XCTest
@testable import StudyiOS
import CoreData

final class CoreDataTest: XCTestCase {
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

    func test_엔티티를_스키마에서_삭제하더라도_데이터베이스에_저장된_내용은_제거되지_않는다() throws {
        // given
        let oldContainer = try startPersistentContainer("MenuLayout")
        insertMenuLayout(key: .mainHome, value: testMenuListJson, context: oldContainer.viewContext)
        try oldContainer.viewContext.save()
        
        // when
        let newContainer = try migrate(container: oldContainer, to: "MenuLayout_2")
        let mappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: oldContainer.managedObjectModel, destinationModel: newContainer.managedObjectModel)
        
        // then
        XCTAssertNotNil(mappingModel)
        
        let menuLayoutObjects: [NSManagedObject] = try getMenuLayouts(in: oldContainer.viewContext)
        XCTAssertEqual(menuLayoutObjects.count, 1)
        
        let menuLayouts = menuLayoutObjects.compactMap {
            $0.value(forKey: "key_rawValue") as? String
        }
        XCTAssertEqual(menuLayouts.count, 1)
    }
    
    func test_oldContainer에_존재하는_row제거() throws {
        // given
        let oldContainer = try startPersistentContainer("MenuLayout")
        let object = insertMenuLayout(key: .mainHome, value: testMenuListJson, context: oldContainer.viewContext)
        try oldContainer.viewContext.save()
        
        let newContainer = try migrate(container: oldContainer, to: "MenuLayout_2")
        let mappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: oldContainer.managedObjectModel, destinationModel: newContainer.managedObjectModel)
        
        // when
        oldContainer.viewContext.delete(object)

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuLayout")
        let rowCount: Int = try oldContainer.viewContext.count(for: fetchRequest)
        
        // then
        XCTAssertNotNil(mappingModel)
        XCTAssertNoThrow(
            try oldContainer.viewContext.save()
        )
        XCTAssertEqual(rowCount, .zero)
    }
}

extension CoreDataTest {
    @discardableResult
    private func insertMenuLayout(
        key: MenuLayout.Key,
        value: String,
        context: NSManagedObjectContext
    ) -> NSManagedObject {
        let object: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "MenuLayout", into: context)
        object.setValue(key.rawValue, forKey: "key_rawValue")
        object.setValue(value, forKey: "layout_json")
        return object
    }
    
    private func getMenuLayouts(in context: NSManagedObjectContext) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MenuLayout")
        fetchRequest.includesSubentities = false
        fetchRequest.resultType = .managedObjectResultType
        
        do {
            let result: [NSManagedObject] = try context.fetch(fetchRequest) as [NSManagedObject]
            return result
        } catch {
            print("$$ insertMenuLayout error: ", error)
            return []
        }
    }
}
