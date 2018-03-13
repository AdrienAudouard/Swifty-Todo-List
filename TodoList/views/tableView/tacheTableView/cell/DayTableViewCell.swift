//
//  DayTableViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit

class DayTableViewCell: CustomTableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.applyTheme()
        
        self.height = 60
    }
    
    override func applyTheme() {
        super.applyTheme()
        
        let t = AppPreferences.sharedInstance.theme!
        
        self.contentView.backgroundColor = t.backgroundColor
        dayLabel.textColor = t.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func update(_ object: Any) {
        guard let title = object as? String else {
            return
        }
        
        dayLabel.text = title
    }

}
