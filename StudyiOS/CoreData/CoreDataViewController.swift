//
//  CoreDataViewController.swift
//  StudyiOS
//
//  Created by nylah.j on 2023/10/06.
//

import UIKit

class CoreDataViewController: UIViewController {
    let coreDatAdapater = CoreDataAdapter()
    let jsonLoader = JsonLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        testDeviceLockedEnv()
    }
    
    func testDeviceLockedEnv() {
        Task {
            // ViewController에서 생성한 Task 이기에 "MainActor"에서 실행됨 -> MainThread에서 실행됨
            await coreDatAdapater.getCachedMenuList(key: .mainHome)
            let json: String = jsonLoader.loadLayoutJson()
            coreDatAdapater.saveMenuList(key: .mainHome, cachedValue: json)
        }
    }
}
