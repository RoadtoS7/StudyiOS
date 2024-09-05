//
//  AppDelegate.swift
//  StudyiOS
//
//  Created by nylah.j on 2022/06/17.
//

import UIKit
import OSLog

let willShowLifecycleLog: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let logger = Logger()
    

    /// not runing -> inactive
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if willShowLifecycleLog {
            logger.log("$$ didFinishLaunchingWithOptions")
        }
        return true
    }
    
    /// inactive -> active
    func applicationDidBecomeActive(_ application: UIApplication) {
        if willShowLifecycleLog {
            logger.log("$$ applicationDidBecomeActive")
        }
    }
    
    /// active -> inactive
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    /// inactive -> background
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    /// background -> foreground (inactive)
    func applicationWillEnterForeground(_ application: UIApplication) {
        if willShowLifecycleLog {
            logger.log("$$ applicationWillEnterForeground")
        }
    }
    
    /// app termination
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
   
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        if #available(iOS 13.0, *) { return }
        
        window = UIWindow()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }
    
    // 공식문서에서는 iOS13이상이면 이걸 쓰라고 했는데, deprecated 됬다고 나온다.
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}

