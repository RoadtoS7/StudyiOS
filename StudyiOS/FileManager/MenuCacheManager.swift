//
//  MenuCacheManager.swift
//  Tako
//
//  Created by nylah.j on 2023/10/06.
//  Copyright © 2023 tapasmedia. All rights reserved.
//

import Foundation

final class MenuCacheManager {
    static let shared: MenuCacheManager = .init()
    
    private let fileManager: FileManager = FileManager.default
    private var cache: [MenuLayout.Key : Json] = [:]
    typealias Json = Data
    
    private lazy var cacheDirPath: String = {
        let tmpDirectoryPath: String
        if #available(iOS 16.0, *) {
            tmpDirectoryPath = fileManager.temporaryDirectory.path()
        } else {
            tmpDirectoryPath = fileManager.temporaryDirectory.path
        }

        return tmpDirectoryPath + "/MenuCache"
//        return fileManager.temporaryDirectory.absoluteString + "/MenuCache"
    }()
    
    private func cacheFilePath(key: MenuLayout.Key) -> String {
        cacheDirPath + key.rawValue
    }
    
    private init() {
        makeCacheDirIfNotExist()
    }
    
    private func makeCacheDirIfNotExist() {
        if fileExist(atPath: cacheDirPath) == false {
            do {
                try fileManager.createDirectory(atPath: cacheDirPath, withIntermediateDirectories: true)
            } catch {
                print("$$ makeCacheDirIfNotExist error: ", error)
            }
        }
    }
    
    private func fileExist(atPath path: String) -> Bool {
        var isDirectory : ObjCBool = false
        let fileExist: Bool = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return fileExist && isDirectory.boolValue
    }
    
    func cacheMenu<Value: Encodable>(key: MenuLayout.Key, value: Value) {
        makeCacheDirIfNotExist()
        saveMenu(key: key, value: value)
    }
    
    private func saveMenu(key: MenuLayout.Key, value: some Encodable) {
        let filePath = cacheFilePath(key: key)
        let data: Data? = encode(value)
        
        let result = fileManager.createFile(atPath: filePath, contents: data)
        let resultText: String = result ? "성공" : "실패"
        cache[key] = data
        print("$$ menu 캐싱 파일 저장 :", resultText)
    }
    
    func menuList<CachedValue: Decodable>(key: MenuLayout.Key) -> CachedValue? {
        if cache[key] == nil {
            loadMenuListInMemory(key: key)
        }
        
        guard let cachedJson: Json = cache[key] else {
            return nil
        }
        
        let cachedValue: CachedValue? = decode(data: cachedJson)
        if let cachedValue {
            print("$$ menuList를 캐시로부터 로딩하여 반환함")
        }
        return cachedValue
    }
    
    func loadAllMenuListInMemory() {
        MenuLayout.Key.allCases
            .forEach { key in
                loadMenuListInMemory(key: key)
            }
    }
    
    private func loadMenuListInMemory(key: MenuLayout.Key) {
        let filePath = cacheFilePath(key: key)
        guard let content: Data = fileManager.contents(atPath: filePath) else {
            return
        }
        
        cache[key] = content
    }
    
    func deleteAllCachedMenu() {
        MenuLayout.Key.allCases
            .forEach { key in
                deleteMenu(key: key)
                cache[key] = nil
            }
    }
    
    private func deleteMenu(key: MenuLayout.Key) {
        let path = cacheFilePath(key: key)

        guard fileExist(atPath: path) else {
            return
        }
        do {
            try fileManager.removeItem(atPath: path)
            cache[key] = nil
        } catch {
            print("$$ deleteMenu error: ", error)
        }
    }
    
    func decode<CachedValue: Decodable>(data: Data) -> CachedValue? {
        let jsonDecoder = JSONDecoder()
        
        if let cachedValue = try? jsonDecoder.decode(CachedValue.self, from: data) {
            return cachedValue
        }
        return nil
    }
    
    func encode(_ encodable: some Encodable) -> Data? {
        return try? JSONEncoder().encode(encodable)
    }
}
