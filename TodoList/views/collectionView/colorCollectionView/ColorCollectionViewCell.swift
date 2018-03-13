//
//  ColorCollectionViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 10/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    var color: UIColor? {
        didSet {
            colorView.backgroundColor = color
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.4, animations: {
                if self.isSelect {
                    self.colorView.layer.borderWidth = 4
                    self.colorView.layer.borderColor = UIColor.black.cgColor
                } else {
                    self.colorView.layer.borderWidth = 0
                }
            })

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.layer.masksToBounds = true
    }
}
