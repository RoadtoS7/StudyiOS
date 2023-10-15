//
//  FileSystem.swift
//  StudyiOS
//
//  Created by 김수현 on 2023/10/15.
//

import Foundation

func printDocumentsURL() {
    let docURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    docURLs.forEach { print("docURLs: ", $0.path) }
    print("docURL: ", docURL?.path)
}

func prinApplicationSupportURL() {
    let supportURLs = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    let supportURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    supportURLs.forEach { print("supportURLS: ", $0.path) }
    print("supportURL: ", supportURL?.path)
}

func printCacheURL() {
    let cacheURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    let cacheURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    cacheURLs.forEach { print("cacheURLs: ", $0.path) }
    print("cacheURL: ", cacheURL?.path)
}

func printTmpURL() {
    let tmpURL = FileManager.default.temporaryDirectory
    print("tmpURL: ", tmpURL)
}
