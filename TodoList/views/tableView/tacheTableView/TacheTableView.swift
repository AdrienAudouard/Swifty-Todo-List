//
//  TacheTableView.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import RxSwift

class TacheTableView: UITableView, UITableViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var sections: [Section] {
        didSet {
            //self.reloadData()
        }
    }
        
    var taskDeleted = PublishSubject<IndexPath>()
    var taskClicked = PublishSubject<Task>()
    
    required init?(coder aDecoder: NSCoder) {
        self.sections = [Section]()
        
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        var f = CGRect.zero
        f.size.height = .leastNormalMagnitude
        self.tableHeaderView = UIView(frame: f)
        self.tableFooterView = UIView(frame: f)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(hex: "2C3E50")
        header.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 19)
        
        let bgView = UIView(frame: view.frame)
        bgView.backgroundColor = UIColor(hex: "ECF0F1")
        header.backgroundView = bgView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  60
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: .normal, title: "Delete") { (_, _) in
            self.taskDeleted.onNext(indexPath)
        }
        
        deleteAction.backgroundColor = UIColor(hex: "#e74c3c")
        
        return [deleteAction]
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
