//
//  AppDelegate.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Realm
import RealmSwift
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
    
    // Create a destination for the system console log (via NSLog)
    let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")
    
    // Optionally set some configuration options
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = false
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = false
    systemDestination.showDate = true
    
    // Add the destination to the logger
    log.add(destination: systemDestination)
    
    return log
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(
            schemaVersion: 8,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, _ in
            })
        
        Realm.Configuration.defaultConfiguration = config
        
        IQKeyboardManager.sharedManager().enable = true
        
        if AppPreferences.sharedInstance.firstLaunch {
            ListManager.createBaseLists()
        }
                
        return true
    }
}
