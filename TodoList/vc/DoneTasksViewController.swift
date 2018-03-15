//
//  DoneTasksViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 14/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class DoneTasksViewController: UIViewController {

    @IBOutlet weak var taskTableView: TacheTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTableView.sections = Section.createSectionWithDoneTasks()
    }
}

extension DoneTasksViewController: TaskProtocol {
    func newTaskCreated(task newTask: Task) {
        
    }
    
    func mustRemoveTask(task: Task) {
        TaskManager.remove(task)
        taskTableView.reloadData()
    }
}
