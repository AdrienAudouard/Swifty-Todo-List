//
//  ListCollectionViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var listNameLabel: UILabel!
    
    var list: List? {
        didSet {
            colorView.backgroundColor = list?.color
            listNameLabel.text = list?.name
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.frame.width / 2
        
        backgroundColorView.backgroundColor = UIColor.clear
        
        backgroundColorView.layer.cornerRadius = 15
        backgroundColorView.layer.borderWidth = 1
        backgroundColorView.layer.borderColor = UIColor(hex: "95a5a6").cgColor
    }
    
    func updateUI() {
        UIView.animate(withDuration: 0.2) {
            if self.isSelect {
                self.backgroundColorView.backgroundColor = self.list?.color
                self.listNameLabel.textColor = UIColor.white
                self.colorView.backgroundColor = UIColor.white
                self.backgroundColorView.layer.borderWidth = 0
            } else {
                self.backgroundColorView.backgroundColor = UIColor.white
                self.backgroundColorView.layer.borderWidth = 1
                self.listNameLabel.textColor = UIColor.black
                self.colorView.backgroundColor = self.list?.color
            }
        }
    }
}
