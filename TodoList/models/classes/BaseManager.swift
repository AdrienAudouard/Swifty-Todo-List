//
//  BaseManager.swift
//  TodoList
//
//  Created by Adrien Audouard on 12/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class BaseManager<T: Object> {
    
    /// Return the next id available for a new T  object
    ///
    /// - Returns: new ID
    class func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(T.self).max(ofProperty: "_id") as Int? ?? 0) + 1
    }
    
    /// Save an object into the realm database
    ///
    /// - Parameter object: Object to save
    class func save(_ object: T) {
        let realm = try! Realm()
        
        try! realm.safeWrite {
            realm.add(object, update: true)
        }
    }
    
    
    /// Delete an object of the realm database
    ///
    /// - Parameter object: Object to delete
    class func remove(_ object: T) {
        let realm = try! Realm()
        
        try! realm.safeWrite {
            realm.delete(object)
        }
    }
    
    /// Return all T objects saved in the realm databse
    ///
    /// - Returns: Array containing all objects founds
    class func getAll() -> [T]{
        let realm = try! Realm()
        let objs = realm.objects(T.self)
        
        return Array(objs)
    }
}
