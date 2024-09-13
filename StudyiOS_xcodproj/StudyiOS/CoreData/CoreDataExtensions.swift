//
//  CoreDataExtension.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/19.
//

import Foundation
import CoreData

extension NSManagedObjectModel {
    var entityNames: [String] {
        entities.map { $0.name ?? "" }
    }
    
    func diffEntityNames(with objectModel: NSManagedObjectModel) -> [String] {
        let diff = diffEntityVersionHashes(with: objectModel)
        return entities
            .filter { diff.contains($0.versionHash) }
            .map { $0.name ?? "" }
    }
    
    func diffEntityVersionHashes(with objectModel: NSManagedObjectModel) -> [Data] {
        let entityHashes = entities.map { $0.versionHash }
        let otherEntityHashes = objectModel.entities.map { $0.versionHash }
        let diff = Set(entityHashes).symmetricDifference(otherEntityHashes)
        return Array(diff)
    }
}

extension NSManagedObjectContext {
    func deleteData(inModel storeModel: NSManagedObjectModel, notExistIn toModel: NSManagedObjectModel) {
        storeModel.diffEntityNames(with: toModel)
            .filter({ entityName in
                containsData(ofEntityName: entityName)
            })
            .map { entityName in
                NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            }
            .map { fetchRequest in
                NSBatchDeleteRequest(fetchRequest: fetchRequest)
            }
            .forEach { deleteRequest in
                do {
                    try execute(deleteRequest)
                }
                catch {
                    print("$$ error: ", error)
                }
            }
    }
    
    func containsData(ofEntityName entityName: String) -> Bool {
        let contains = self.registeredObjects
            .map({ managedObject in
                managedObject.entity.name
            })
            .contains(entityName)
        return contains
    }
}
