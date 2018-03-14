//
//  TacheTableView.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class TacheTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var sections: [Section] {
        didSet {
            self.reloadData()
        }
    }
    
    weak var taskDelegate: TaskProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        self.sections = [Section]()
        
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.dataSource = self
        
        var f = CGRect.zero
        f.size.height = .leastNormalMagnitude
        self.tableHeaderView = UIView(frame: f)
        self.tableFooterView = UIView(frame: f)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "TacheTableViewCell") as! TacheTableViewCell
        
        c.taskModel = TaskCellModel(sections[indexPath.section].cell[indexPath.row])
        c.delegate = self
        c.selectionStyle = .none
        
        return c
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell") as! DayTableViewCell
        header.tag = 1811
        header.update(sections[section].title)
        
        let view = UIView(frame: header.bounds)
        view.addSubview(header)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.dequeueReusableCell(withIdentifier: "TacheTableViewCell") as! TacheTableViewCell).height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  (tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell") as! DayTableViewCell).height
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let t = self.sections[indexPath.section].cell.remove(at: indexPath.row)
                        
            self.taskDelegate?.mustRemoveTask(task: t)
        }
    }
    
    func applyTheme() {
        let t = AppPreferences.sharedInstance.theme!
        self.backgroundColor = t.backgroundColor

        self.visibleCells.forEach { (cell) in
            cell.applyTheme()
        }
        
        self.reloadData()
    }
}

extension TacheTableView: TaskDoneDelegate {
    func done(task: Task, cell: UITableViewCell) {
        task.done = true
        
        let indexPath = self.indexPath(for: cell)!
        
        DispatchQueue.main.async {
            self.sections[indexPath.section].cell.remove(at: indexPath.row)
            self.deleteRows(at: [indexPath], with: .automatic)
        }        
    }
    
    
}
