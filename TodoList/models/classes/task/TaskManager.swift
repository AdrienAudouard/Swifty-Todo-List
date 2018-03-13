//
//  TaskManager.swift
//  TodoList
//
//  Created by Adrien Audouard on 12/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import Realm
import RealmSwift



/// The task manager is used to save, delete and get task from the databse

class TaskManager: BaseManager<Task> {
    /// Return all the tasks for a specific date
    ///
    /// - Parameter date: Date we search
    /// - Returns: Tasks founds at this date
    class func get(at date: Date, isDone: Bool = false) -> [Task] {
        let realm = try! Realm()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let d = formatter.string(from: date)
        
        let predicate = NSPredicate(format: "_dateFormated = %@ AND _done = %@", d, NSNumber(value: isDone))
        
        let t = realm.objects(Task.self).filter(predicate)
        
        return Array(t)
    }
    
    class func belong(to list: List) -> [Task] {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "_list._id = %@", list.id)
        
        let result = realm.objects(Task.self).filter(predicate)
        
        return Array(result)
    }
    
    class func belong(to list : List, date: Date) -> [Task]{
        var tasks = get(at: date)
        _ = tasks.remove(handler: { $0.id ==  list.id})
        
        return tasks
    }
    
    
    /// Return the number of task to do at a specific date
    ///
    /// - Parameter date: Date we search
    /// - Returns: Number of tasks
    class func numberOfeventsForDate(date: Date, isDone: Bool = false) -> Int{
        let realm = try! Realm()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let d = formatter.string(from: date)
        
        let predicate = NSPredicate(format: "_dateFormated = %@ AND _done = %@", d, NSNumber(value: isDone))
        
        let tasks = realm.objects(Task.self).filter(predicate)
        
        return tasks.count
    }
    
    
    /// Found tasks after a specific date
    ///
    /// - Parameter date: Date after the tasks must be
    /// - Returns: Tasks founds
    class func after(date: Date, isDone: Bool = false) -> [Task] {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "_date > %@ AND _done = %@", date as NSDate,NSNumber(value: isDone))
        
        let t = realm.objects(Task.self).filter(predicate)
        
        return Array(t)
    }
    
    class func before(date: Date, isDone: Bool = false) -> [Task] {
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "_date < %@ AND _done = %@", date as NSDate, NSNumber(value: isDone))
        
        let t = realm.objects(Task.self).filter(predicate)
        
        return Array(t)
    }
}
