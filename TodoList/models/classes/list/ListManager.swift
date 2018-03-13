//
//  ListManager.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ListManager: BaseManager<List> {

    /// Factory for create a List, the list is saved in thr realm database
    ///
    /// - Parameters:
    ///   - name: Name of the list
    ///   - color: Color of the list
    /// - Returns: List created
    class func create(name: String, color: UIColor) -> List {
        let list = List(name: name, color: color)
        
        save(list)
        
        return list
    }
    
    class func createBaseLists() {
        guard getAll().count == 0 else {
            return
        }
        
        _ = create(name: "Work", color: UIColor(hex: "3498db"))
        _ = create(name: "Personnal", color: UIColor(hex: "2ecc71"))
    }
}
