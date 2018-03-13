//
//  FilterListDelegate.swift
//  TodoList
//
//  Created by Adrien Audouard on 13/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

protocol FilterListDelegate: class {
    func addFilter(list: List)
    func removeFilter(list: List)
}
