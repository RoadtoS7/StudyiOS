//
//  CoreDataContextSaveIssue.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/05.
//

/**
 CoreData에서 context.save()를 실행할 때 하기와 같은 이슈 원인을 파악하기 위함.
 Fatal Exception: NSInternalInconsistencyException
 This NSPersistentStoreCoordinator has no persistent stores (device locked). It cannot perform a save operation.
 */

import CoreData

extension MenuLayout {
    enum Key: String, CaseIterable {
        case mainHome           // 메인 > 홈
        case rankingComic       // 랭킹 > comic
        case rankingNovel       // 랭킹 > novel
        case freeToRead         // 연재무료
        case ongoing            // 요일 연재
        case newComic           // 오늘 신작 > comic
        case newNovel           // 오늘 신작 > novel
        case genre              // 장르
        case originalComic      // 타파스 오리지널 > comic
        case originalNovel      // 타파스 오리지널 > novel
    }
    
    var key: Key? {
        set {
            key_rawValue = newValue?.rawValue
        }
        get {
            Key(rawValue: key_rawValue ?? "")
        }
    }
}

extension Sequence where Element == MenuLayout {
    func toDict() -> [MenuLayout.Key:String] {
        self.reduce(into: [MenuLayout.Key:String]()) { partialResult, layout in
            guard let key = layout.key else {
                return
            }
            partialResult[key] = layout.layout_json
        }
    }
}

final class JsonLoader {
    func loadLayoutJson() -> String {
        let bundle = Bundle.main
        guard let url: URL = bundle.url(forResource: "MenuLayout", withExtension: "txt") else {
            print("$$ MenuLayout.txt not exist")
            return ""
        }
        
        guard let contentText: String = try? String(contentsOf: url) else {
            print("$$ MenuLayout.txt content not exist")
            return ""
        }

        print("$$ json: ", contentText)
        return contentText
    }
}

class CoreDataAdapter {
    var menuLayoutArray: [MenuLayout] = []
    var menuLayoutDict: [MenuLayout.Key : String] {
        return menuLayoutArray.toDict()
    }
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MenuLayout")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("$$ load persistent store error: ", error)
            }
        })
        return container
    }()
    
    func getCachedMenuList(key: MenuLayout.Key) async {
        await withCheckedContinuation { continuation in
            getCachedMenuList(key: key) { [weak self] menuLayouts, error in
                guard error == nil, let menuLayouts = menuLayouts else {
                    print("$$ getCachedMenuList error: ", error!)
                    continuation.resume()
                    return
                }
                
                self?.menuLayoutArray = menuLayouts
                continuation.resume()
            }
        }
    }
    
    // MARK: MenuLayout
    func getCachedMenuList(key: MenuLayout.Key, completionHandler: @escaping ([MenuLayout]?, Error?) -> Void) {
        let request: NSFetchRequest<MenuLayout> = MenuLayout.fetchRequest()
        
        let asyncFetchRequest: NSAsynchronousFetchRequest<MenuLayout> = .init(fetchRequest: request) { asynchronousResult in
            if let result = asynchronousResult.finalResult {
                completionHandler(result, nil)
                return
            }
            
            completionHandler(nil, NSError(domain: "result is nil", code: -1))
        }
        
        do {
            try context.execute(asyncFetchRequest)
        } catch {
            completionHandler(nil, error)
        }
    }
    
    func saveMenuList<CachedValue: Encodable>(key: MenuLayout.Key, cachedValue: CachedValue) {
        guard let data: Data = try? JSONEncoder().encode(cachedValue),
              let json: String = String(data: data, encoding: .utf8) else {
            return
        }
        
        // find old value and delete if any
        deleteMenuList(key: key)
        
        // create new one and add to DB
        let menuLayout = MenuLayout(context: self.context)
        menuLayout.key = key
        menuLayout.layout_json = json
        menuLayoutArray.append(menuLayout)
        
        try? context.save()
    }
    
    private func deleteMenuList(key: MenuLayout.Key) {
        menuLayoutArray = menuLayoutArray.filter { (menu) -> Bool in
            if menu.key == key {
                context.delete(menu)
                return false
            } else {
                return true
            }
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("$$ Core Data save error: ", error)
        }
    }
}
