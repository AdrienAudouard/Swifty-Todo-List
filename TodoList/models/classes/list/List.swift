//
//  List.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import UIKit

class List: Object {
    @objc dynamic private var _id: Int = 0
    @objc dynamic private var _name: String = ""
    @objc dynamic private var _color: String = ""
    
    var id: Int {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    var color: UIColor {
        return UIColor(hex: _color)
    }
    
    convenience init(name: String, color: UIColor) {
        self.init()
        
        self._name = name
        self._color = color.toHexString()
        self._id = ListManager.incrementID()
    }
    
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["hourString", "id", "taskName", "date", "dateFormated", "done"]
    }
}
