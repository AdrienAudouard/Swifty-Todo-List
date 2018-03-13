//
//  TaskDoneDelegate.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

protocol TaskDoneDelegate: class {
    func done(task: Task, cell: UITableViewCell)
}
