//
//  ListTableView.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var lists: [List] = [List]() {
        didSet {
            self.reloadData()
            scrollToRow(at: IndexPath.init(row: lists.count - 2, section: 0), at: .bottom, animated: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        dataSource = self
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        cell.list = lists[indexPath.row + 1]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let listRemoved = lists.remove(at: indexPath.row + 1)
            ListManager.remove(listRemoved)
            
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
        }
    }
}
