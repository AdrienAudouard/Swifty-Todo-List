//
//  TaskProtocol.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

protocol TaskProtocol: class {
    func newTaskCreated(task newTask: Task)
    func mustRemoveTask(task: Task)
}
