//
//  SelectListCollectionViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 12/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class SelectListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var list: List? {
        didSet {
            titleLabel.text = list?.name
            titleLabel.textColor = list?.color
        }
    }
    
    var isSelect: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedBackgroundView.layer.masksToBounds = true
        roundedBackgroundView.layer.cornerRadius = 8
        
        roundedBackgroundView.layer.cornerRadius = 15
        roundedBackgroundView.layer.borderWidth = 1
        roundedBackgroundView.layer.borderColor = UIColor(hex: "#bdc3c7").cgColor
    }
    
    func updateUI() {
        UIView.animate(withDuration: 0.2) {
            if self.isSelect {
                self.titleLabel.textColor = UIColor.white
                self.roundedBackgroundView.backgroundColor = self.list?.color
                self.roundedBackgroundView.layer.borderWidth = 0
            } else {
                self.roundedBackgroundView.layer.borderWidth = 1
                self.titleLabel.textColor = self.list?.color
                self.roundedBackgroundView.backgroundColor = UIColor.white
            }
        }

    }
}
