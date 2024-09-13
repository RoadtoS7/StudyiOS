//
//  FileManagerViewController.swift
//  StudyiOS
//
//  Created by 김수현 on 2023/10/15.
//

import UIKit

class FileManagerViewController: UIViewController {
    private let domainMask: [FileManager.SearchPathDomainMask] = [.userDomainMask, .localDomainMask, .systemDomainMask, .allDomainsMask, .networkDomainMask]

    override func viewDidLoad() {
        super.viewDidLoad()

        domainMask.forEach {
            print("$$ domainMask: \($0.self)")
            printDocumentsURL(domainMask: $0)
            prinApplicationSupportURL(domainMask: $0)
            printCacheURL(domainMask: $0)
            printAllLibraryURL(domainMask: $0)
            printContentsOfLib(domainMask: $0)
            print()
        }
        
        printTmpURL()
        printNetworkMask()
        printSystemMask()
        printLocalMask()
        printAllDomainMask()
    }
}
