//
//  FileManagerTest.swift
//  StudyiOSTests
//
//  Created by nylah.j on 2023/10/06.
//

import XCTest

final class FileManagerTest: XCTestCase {
    private let fileManager: FileManager = .default

    override func setUpWithError() throws {
        let fileURL = fileManager.temporaryDirectory.appendingPathComponent("data")
        let filePath = fileURL.absoluteString
        let fileExists = fileManager.fileExists(atPath: filePath)
        print("$$ fileExists: ", fileExists)
        if fileManager.fileExists(atPath: filePath) {
            try fileManager.removeItem(atPath: filePath)
            print("$$ removeItem")
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_파일이_이미_존재할때_덮어쓰기_한다() {
        // given
        let fileURL = fileManager.temporaryDirectory.appendingPathComponent("data")
        
        let filePath: String
        if #available(iOS 16.0, *) {
            filePath = fileURL.path()
        } else {
            filePath = fileURL.path
        }
        
        let oldData = Data(repeating: 1, count: 8)
        let newData = Data(repeating: 2, count: 8)
        
        
        let oldDataWritingResult = fileManager.createFile(atPath: filePath, contents: oldData)
        let fileExists = fileManager.fileExists(atPath: filePath)
        print("$$ fileExists: ", fileExists)
        if oldDataWritingResult == false {
            XCTFail("old data writing is fail")
            return
        }
        
        // when
        let newDataWritingResult = fileManager.createFile(atPath: filePath, contents: newData)
        if newDataWritingResult == false {
            XCTFail("new data writing is fail")
            return
        }
        
        // then
        guard let dataFromFile: Data = fileManager.contents(atPath: filePath) else {
            XCTFail("data at file system is nil")
            return
        }
        
        
        let textFromFile = String(data: dataFromFile, encoding: .utf8)
        let textFromOldData = String(data: oldData, encoding: .utf8)
        let textFromNewData = String(data: newData, encoding: .utf8)
        
        XCTAssertEqual(textFromFile, textFromNewData)
        XCTAssertNotEqual(textFromFile, textFromOldData)
    }
}
