//
//  CoreDataUtils.swift
//  Tako
//
//  Created by nylah.j on 2023/10/12.
//  Copyright © 2023 tapasmedia. All rights reserved.
//

import Foundation
import CoreData

class MigrationManager {
    var storeURL: URL = {
        let storeFileName = "Tako.sqlite"
        let url = NSPersistentContainer.defaultDirectoryURL()
        
        return URL(
            fileURLWithPath: storeFileName,
            relativeTo: url
        )
    }()
    
    /// 현재 디바이스에 생성된 store의 스키마에 해당하는 object model을 반환
    var storeModel: NSManagedObjectModel? {
        let modleName: String = "Tako"
        let versions = Bundle.main
            .urls(
                forResourcesWithExtension: "mom",
                subdirectory: "\(modleName).momd") ?? []
        
        
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
    
    func performMigration(storeURL: URL, storeModel: NSManagedObjectModel?, destinationModel: NSManagedObjectModel? = nil) -> (URL?, String) {
        let destinationModel = destinationModel ?? CoreData.latestVersionModel
        guard store(at: storeURL, isCompatibleWithModel: destinationModel) == false else {
            print("$$ 현재 데이터 모델이 가장 최신 버전에 해당하므로 마이그레이션하지 않는다.")
            return (nil, "")
        }
        
        guard let storeModel = storeModel else {
            print("$$ 데이터베이스 파일이 존재하지 않으므로 마이그레이션 하지 않는다.")
            return (nil, "")
        }
        
        return migrateStoreAt(storeURL: storeURL, fromModel: storeModel, toModel: destinationModel)
    }
    
    private func store(
        at storeURL: URL,
        isCompatibleWithModel model: NSManagedObjectModel
    ) -> Bool {
        let storeMetadata = metadataForStoreAtURL(storeURL: storeURL)
        return model.isConfiguration(withName: nil, compatibleWithStoreMetadata: storeMetadata)
    }
    
    private func metadataForStoreAtURL(storeURL: URL) -> [String: Any] {
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

    private func migrateStoreAt(
        storeURL: URL,
        fromModel: NSManagedObjectModel,
        toModel: NSManagedObjectModel,
        mappingModel: NSMappingModel? = nil
    ) -> (URL?, String) {
        let migrationManager = NSMigrationManager(sourceModel: fromModel, destinationModel: toModel)
        
        let migrationMappingModel: NSMappingModel
        if let mappingModel {
            migrationMappingModel = mappingModel
        } else {
            do {
                migrationMappingModel = try NSMappingModel.inferredMappingModel(forSourceModel: fromModel, destinationModel: toModel)
            } catch {
                print("$$ mappging model error: ", error)
                return (nil, "")
            }
        }
        
        let targetURL = storeURL.deletingLastPathComponent()
        let destinationName = storeURL.lastPathComponent + "~1"
//        let destinationURL = targetURL
//            .appendingPathComponent(destinationName)
        let destinationURL: URL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("sqlite")
        
        print("$$ From Model: \(fromModel.entityVersionHashesByName)")
        print("$$ To Model: \(toModel.entityVersionHashesByName)")
        print("$$ Migrating store \(storeURL) to \(destinationURL)")
        
        // 4
        let success: Bool
        do {
            try migrationManager.migrateStore(
                from: storeURL,
                sourceType: NSSQLiteStoreType,
                options: nil,
                with: migrationMappingModel,
                toDestinationURL: destinationURL,
                destinationType: NSSQLiteStoreType,
                destinationOptions: nil)
            success = true
        } catch {
            success = false
            print("$$ Migration failed: \(error)")
        }
        
        // 5
        if success {
            print("$$ Migration Completed Successfully")
            
            let fileManager = FileManager.default
//            do {
//                try fileManager.removeItem(at: storeURL)
//                try fileManager.moveItem(
//                    at: destinationURL,
//                    to: storeURL)
//                
//            } catch {
//                print("$$ Error migrating \(error)")
//            }
        }
        
        return (destinationURL, destinationName)
    }

    func versionModel(versionName: String) -> NSManagedObjectModel {
        let model = versionURLs(modelName: "Tako")
            .first { url in
                url.lastPathComponent == "\(versionName).mom"
            }.flatMap(NSManagedObjectModel.init)
        return model ?? NSManagedObjectModel()
    }

    private func versionURLs(modelName: String) -> [URL] {
        Bundle.main
              .urls(
                forResourcesWithExtension: "mom",
                subdirectory: "\(modelName).momd") ?? []
    }
}
