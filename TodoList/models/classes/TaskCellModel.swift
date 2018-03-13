//
//  TaskCellModel.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

class TaskCellModel {
    var titleLabel: String
    var dateLabel: String
    var backgroundColor: UIColor
    
    var task: Task
    
    init(_ task: Task) {
        self.task = task
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        titleLabel = task.taskName
        
        formatter.dateFormat = "HH:mm"
        
        dateLabel = "\(formatter.string(from: task.date))"
        
        backgroundColor = task.list.color
    }
}
