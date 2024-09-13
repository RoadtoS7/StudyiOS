//
//  CoreDataMigrationUtil.swift
//  TapasTests
//
//  Created by nylah.j on 2023/09/14.
//  Copyright © 2023 tapasmedia. All rights reserved.
//

import XCTest
import CoreData
@testable import StudyiOS

private let storeType = NSSQLiteStoreType

func startPersistentContainer(_ versionName: String) throws -> NSPersistentContainer {
    let storeURL = makeTemporaryStoreURL()
    let model = managedObjectModel(versionName: versionName)

    let container = makePersistentContainer(storeURL: storeURL,
                                            managedObjectModel: model)
    container.loadPersistentStores { _, error in
        XCTAssertNil(error)
    }

    return container
}

func migrate(container: NSPersistentContainer, to versionName: String) throws -> NSPersistentContainer {
    let sourceModel = container.managedObjectModel
    let destinationModel = managedObjectModel(versionName: versionName)

    let sourceStoreURL = storeURL(from: container)
    let destinationStoreURL = makeTemporaryStoreURL()

    let mappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: sourceModel,
                                                               destinationModel: destinationModel)

    let migrationManager = NSMigrationManager(sourceModel: sourceModel,
                                              destinationModel: destinationModel)
    
    try migrationManager.migrateStore(from: sourceStoreURL,
                                      sourceType: storeType,
                                      options: nil,
                                      with: mappingModel,
                                      toDestinationURL: destinationStoreURL,
                                      destinationType: storeType,
                                      destinationOptions: nil)

    let destinationContainer = makePersistentContainer(storeURL: destinationStoreURL,
                                                       managedObjectModel: destinationModel)
    destinationContainer.loadPersistentStores { _, error in
        XCTAssertNil(error)
    }

    return destinationContainer
}

private func makePersistentContainer(storeURL: URL,
                                     managedObjectModel: NSManagedObjectModel) -> NSPersistentContainer {
    let description = NSPersistentStoreDescription(url: storeURL)
    description.shouldMigrateStoreAutomatically = false
    description.type = storeType

    let container = NSPersistentContainer(name: "App Container", managedObjectModel: managedObjectModel)
    container.persistentStoreDescriptions = [description]

    return container
}

private func managedObjectModel(versionName: String) -> NSManagedObjectModel {
    let bundle = Bundle.main
    let managedObjectModelURL = bundle.url(forResource: "MenuLayout", withExtension: "momd")
    let managedObjectModelURLBundle = Bundle(url: managedObjectModelURL!)
    let managedObjectModelVersionURL: URL = managedObjectModelURLBundle!.url(forResource: versionName, withExtension: "mom")!
    return NSManagedObjectModel(contentsOf: managedObjectModelVersionURL)!
}

private func storeURL(from container: NSPersistentContainer) -> URL {
    let description = container.persistentStoreDescriptions.first!
    return description.url!
}

func makeTemporaryStoreURL() -> URL {
    URL(fileURLWithPath: NSTemporaryDirectory())
        .appendingPathComponent(UUID().uuidString)
        .appendingPathExtension("sqlite")
}

@discardableResult
func insertMenuLayout(
    key: MenuLayout.Key,
    value: String,
    context: NSManagedObjectContext
) -> NSManagedObject {
    let object: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "MenuLayout", into: context)
    object.setValue(key.rawValue, forKey: "key_rawValue")
    object.setValue(value, forKey: "layout_json")
    return object
}

func getMenuLayouts(in context: NSManagedObjectContext) throws -> [NSManagedObject] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MenuLayout")
    fetchRequest.includesSubentities = false
    fetchRequest.resultType = .managedObjectResultType
    
    do {
        let result: [NSManagedObject] = try context.fetch(fetchRequest) as [NSManagedObject]
        return result
    } catch {
        print("$$ getMenuLayouts error: ", error)
        return []
    }
}

@discardableResult
func insertPerson(id: Int64, name: String, context: NSManagedObjectContext) -> NSManagedObject {
    let object: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
    object.setValue(id, forKey: "id")
    object.setValue(name, forKey: "name")
    return object
}

func getPersons(in context: NSManagedObjectContext) throws -> [NSManagedObject] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
    fetchRequest.includesSubentities = false
    fetchRequest.resultType = .managedObjectResultType
    
    do {
        let result: [NSManagedObject] = try context.fetch(fetchRequest) as [NSManagedObject]
        return result
    } catch {
        print("$$ getPersons error: ", error)
        return []
    }
}

