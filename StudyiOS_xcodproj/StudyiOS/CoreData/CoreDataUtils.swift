//
//  CoreDataUtils.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/13.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func hasMenuLayoutEntity() -> Bool {
        let menuLayoutName: String = "MenuLayout"
        
        let count = registeredObjects.count
        print("$$ entity in context count: ", count)
        return registeredObjects.contains {
            return $0.entity.name == menuLayoutName }
    }
}

extension NSManagedObjectModel {
    func hasMenuLayoutEntity() -> Bool {
        let menuLayoutName: String = "MenuLayout"
        return entities
            .map { $0.name }
            .contains { $0 == menuLayoutName }
    }
}


func deleteMenuLayoutData(context: NSManagedObjectContext) {
    let versionModel = context.persistentStoreCoordinator?.managedObjectModel
    versionModel?.versionIdentifiers
        .forEach({
            print("$$ delete on version: ", $0)
        })
    
    context.persistentStoreCoordinator?.persistentStores
        .map({ $0.url })
        .forEach({ print("$$ url: ", $0) })
        
        
    guard let storeModel = CoreData.storeModel,
            storeModel.hasMenuLayoutEntity() else {
        print("$$ deleteMenuLayoutData fail: menu layout doesn't exist in model")
        return
    }
    
    guard context.hasMenuLayoutEntity() else {
        print("$$ deleteMenuLayoutData fail: context doesn't have menu layout")
        return
    }
    
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "MenuLayout")
    let batchDeleteRequest: NSBatchDeleteRequest = .init(fetchRequest: fetchRequest)
    batchDeleteRequest.resultType = .resultTypeObjectIDs
    
    do {
        let result: NSPersistentStoreResult = try context.execute(batchDeleteRequest)
        let deleteResult: NSBatchDeleteResult? = result as? NSBatchDeleteResult
        let deletedIds: [NSManagedObjectID] = deleteResult.flatMap { $0.result }
            .flatMap { $0 as? [NSManagedObjectID] }
            ?? [NSManagedObjectID]()
        
        let changes: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deletedIds
        ]
        
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
    } catch {
        print("deleteMenuLayoutData error: \(error)")
    }
}

struct CoreData {
    private static let modelFileName: String = "MenuLayout"
    
    static var latestVersionModel: NSManagedObjectModel = {
        let managedObject = Bundle.main
            .url(forResource: modelFileName, withExtension: "momd")
            .flatMap(NSManagedObjectModel.init)
        ?? NSManagedObjectModel()
        
        managedObject.entities
            .forEach { description in
                print("$$ currentModel entities: ", description.name)
            }
        return managedObject
    }()

    /// 현재 디바이스에 생성된 store의 스키마에 해당하는 object model을 반환
    static var storeModel: NSManagedObjectModel? {
        let versions = Bundle.main
            .urls(
                forResourcesWithExtension: "mom",
                subdirectory: "\(modelFileName).momd") ?? []
        
        
        let firstVersion = versions.compactMap(NSManagedObjectModel.init)
            .first {
                //
                store(at: storeURL, isCompatibleWithModel: $0)
            }
        firstVersion?.entities
            .forEach({ description in
                print("$$ store versino entities: ", description.name)
            })
        return firstVersion
    }
    
    private static func store(
        at storeURL: URL,
        isCompatibleWithModel model: NSManagedObjectModel
    ) -> Bool {
        let storeMetadata = metadataForStoreAtURL(storeURL: storeURL)
        return model.isConfiguration(withName: nil, compatibleWithStoreMetadata: storeMetadata)
    }
    
    private static func metadataForStoreAtURL(storeURL: URL) -> [String: Any] {
        let metadata: [String: Any]
        do {
            metadata = try NSPersistentStoreCoordinator
                .metadataForPersistentStore(
                    ofType: NSSQLiteStoreType,
                    at: storeURL,
                    options: nil)
        } catch {
            metadata = [:]
            print("$$ Error retrieving metadata for store at URL:\(storeURL): \(error)")
        }
        return metadata
    }
    
    static var storeURL: URL = {
        let storeFileName = "StudyiOS.sqlite"
        let url = NSPersistentContainer.defaultDirectoryURL()
        
        return URL(
            fileURLWithPath: storeFileName,
            relativeTo: url
        )
    }()
    
    static func versionModel(versionName: String) -> NSManagedObjectModel {
        let model = versionURLs(modelName: modelFileName)
            .first { url in
                url.lastPathComponent == "\(versionName).mom"
            }.flatMap(NSManagedObjectModel.init)
        return model ?? NSManagedObjectModel()
    }
    
    private static func versionURLs(modelName: String) -> [URL] {
        Bundle.main
              .urls(
                forResourcesWithExtension: "mom",
                subdirectory: "\(modelName).momd") ?? []
    }
}
