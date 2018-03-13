//
//  AppPreferences.swift
//  TodoList
//
//  Created by Adrien Audouard on 05/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class AppPreferences: Object {
    var theme: Theme!
    
    @objc dynamic var id: Int = 0
    
    var usePassword: Bool {
        return _password != ""
    }
    
    @objc dynamic private var _password: String = ""
    @objc dynamic private var _useTouchId = false
    @objc dynamic private var _firstLaunch = true
    
    var password: String {
        get {
            return self._password
        } set(newValue) {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                self._password = newValue
                save()
            }
        }
    }
    
    var useTouchId: Bool {
        get {
            return self._useTouchId
        } set(newValue) {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                self._useTouchId = newValue
                save()
            }
        }
    }
    
    var firstLaunch: Bool {
        get {
            return self._firstLaunch
        } set(newValue) {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                self._firstLaunch = newValue
                save()
            }
        }
    }
    
    static let sharedInstance: AppPreferences = AppPreferences.create()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["password", "useTouchId", "firstLaunch", "usePassword"]
    }
    
    class func create() -> AppPreferences {
        let realm = try! Realm()
        
        guard let prefs = realm.objects(AppPreferences.self).first else {
            let p = AppPreferences()
            
            return p
        }
        
        return prefs
    }
    
    func save() {
        let realm = try! Realm()
        
        try! realm.safeWrite {
            realm.add(self, update: true)
        }
    }
}
