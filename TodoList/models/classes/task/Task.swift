//
//  Task.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxDataSources


/// A Task represent a action the user must do
/// It's represented by a uniquement ID used to save it in local,
/// a name, a dead line and boolean showing if the task is done or not

class Task: Object, IdentifiableType {
    typealias Identity = Int
    
    var identity: Identity {
        if isInvalidated {
            return 0
        }
        return _id
    }
    
    @objc dynamic private var _id: Int = 0
    @objc dynamic private var _taskName: String = ""
    @objc dynamic private var _date: Date = Date()
    @objc dynamic private var _dateFormated: String = ""
    @objc dynamic private var _done: Bool = false
    @objc dynamic private var _list: List?
    
    var id: Int {
        return _id
    }
    
    var taskName: String {
        return _taskName
    }
    
    var date: Date {
        return _date
    }
    
    var dateFormated: String {
        return _dateFormated
    }
    
    var done: Bool {
        get {
            return _done
        } set (newValue) {
            let realm = try! Realm()
            
            try! realm.safeWrite {
                _done = newValue
            }
            
            TaskManager.save(self)
            
        }
    }
    
    var list: List {
        return _list!
    }
    
    
    /// Return the hour of the deadline, with the pattern HH:mm
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: _date)
    }
    
    convenience init(_ name: String, date: Date, list: List) {
        self.init()
        
        self._id = TaskManager.incrementID()
        self._taskName = name
        self._date = date
        self._list = list
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        self._dateFormated = formatter.string(from: date)
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["hourString", "id", "taskName", "date", "dateFormated", "done", "list"]
    }
}
