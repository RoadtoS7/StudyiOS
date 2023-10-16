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
    
    let contents = try? FileManager.default.contentsOfDirectory(atPath: docURL!.path)
    contents?.forEach { print("$$ contents in doc: ", $0) }
}

func printLibraryURL() {
    let libraryURLs = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
    let libraryURL = try? FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    libraryURLs.forEach { print("libraryURL: ", $0.path) }
    print("libraryURL: ", libraryURL?.path)
}

func prinApplicationSupportURL() {
    let supportURLs = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    let supportURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    supportURLs.forEach { print("supportURLS: ", $0.path) }
    print("supportURL: ", supportURL?.path)
}

func printAllLibraryURL() {
    let urls = FileManager.default.urls(for: .allLibrariesDirectory, in: .userDomainMask)
    urls.forEach { print("$$ all library dirs: ", $0.path)}
}

func printContentsOfLib() {
    let libDirectoryURL = try? FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let contents = try? FileManager.default.contentsOfDirectory(atPath: libDirectoryURL!.path)
    contents!.forEach { print("$$ contents of library directory: ", $0) }
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

func printNetworkMask() {
    let networkURLs = FileManager.default.urls(for: .allApplicationsDirectory, in: .networkDomainMask)
    networkURLs.forEach { print("네트워크 - allApplication: ", $0.path) }
}


func printSystemMask() {
    let networkURLs = FileManager.default.urls(for: .allApplicationsDirectory, in: .systemDomainMask)
    networkURLs.forEach { print("시스템 - allApplication: ", $0.path) }
}

func printLocalMask() {
    let networkURLs = FileManager.default.urls(for: .allApplicationsDirectory, in: .allDomainsMask)
    networkURLs.forEach { print("로컬 도메인 - allApplication: ", $0.path) }
}

func printAllDomainMask() {
    let networkURLs = FileManager.default.urls(for: .allApplicationsDirectory, in: .allDomainsMask)
    networkURLs.forEach { print("all 도메인 - allApplication: ", $0.path) }
}

func printDomain() {
    let docURLs = FileManager.default.urls(for: .documentDirectory, in: .localDomainMask)
    let docURL = try? FileManager.default.url(for: .documentDirectory, in: .localDomainMask, appropriateFor: nil, create: false)
    
    docURLs.forEach { print("docURLs: ", $0.path) }
    print("docURL: ", docURL?.path)
}
