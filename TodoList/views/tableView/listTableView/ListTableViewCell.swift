//
//  ListTableViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var list: List? {
        didSet {
            listNameLabel.text = list!.name
            colorView.backgroundColor = list!.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
}
