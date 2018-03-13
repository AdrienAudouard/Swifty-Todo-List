//
//  DateTaskTableViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class DateTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    var task: Task? {
        didSet {
            taskTitleLabel.text = task?.taskName
            dateLabel.text = task?.hourString
        }
    }
}
