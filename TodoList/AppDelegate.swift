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
