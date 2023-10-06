//
//  MenuCacheManager.swift
//  Tako
//
//  Created by nylah.j on 2023/10/06.
//  Copyright © 2023 tapasmedia. All rights reserved.
//

import Foundation

final class MenuCacheManager {
    private let fileManager: FileManager = FileManager.default
    private var cache: [MenuLayout.Key : Decodable] = [:]
    
    private lazy var baseURL: String = {
        fileManager.temporaryDirectory.absoluteString + "/MenuCache"
    }()
    
    private func cacheFilePath(key: MenuLayout.Key) -> String {
        baseURL + key.rawValue
    }
    
    init() {
        makeCacheDirIfNotExist()
    }
    
    private func makeCacheDirIfNotExist() {
        if cacheDirExists() == false {
            do {
                try fileManager.createDirectory(atPath: baseURL, withIntermediateDirectories: true)
            } catch {
                print("$$ makeCacheDirIfNotExist error: ", error)
            }
        }
    }
    
    private func cacheDirExists() -> Bool {
        var isDirectory : ObjCBool = false
        let fileExist: Bool = fileManager.fileExists(atPath: baseURL, isDirectory: &isDirectory)
        return fileExist && isDirectory.boolValue
    }
    
    func cacheMenu<Value: Encodable>(key: MenuLayout.Key, value: Value) {
        makeCacheDirIfNotExist()
        deleteMenu(key: key)
        saveMenu(key: key, value: value)
    }
    
    private func saveMenu(key: MenuLayout.Key, value: some Encodable) {
        let filePath = cacheFilePath(key: key)
        let data: Data? = encode(value)
        
        fileManager.createFile(atPath: filePath, contents: data)
    }
    
    // FileManager에서 읽어서 반환하는 방식
    func menuList<CachedValue: Decodable>(key: MenuLayout.Key) -> CachedValue? {
        let fileName: String = key.rawValue
        let path: String = "\(baseURL)\(fileName)"
        
        guard let content: Data = fileManager.contents(atPath: path) else {
            return nil
        }
        
        let cachedValue: CachedValue? = decode(data: content)
        return cachedValue
    }
    
    func deleteMenu(key: MenuLayout.Key) {
        let path = cacheFilePath(key: key)
        do {
            try fileManager.removeItem(atPath: path)
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
