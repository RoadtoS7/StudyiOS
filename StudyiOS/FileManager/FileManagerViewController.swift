//
//  FileManagerViewController.swift
//  StudyiOS
//
//  Created by 김수현 on 2023/10/15.
//

import UIKit

class FileManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printDocumentsURL()
        prinApplicationSupportURL()
        printCacheURL()
        printTmpURL()
    }
}
