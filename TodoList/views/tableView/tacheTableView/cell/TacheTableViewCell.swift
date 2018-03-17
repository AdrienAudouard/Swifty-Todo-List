//
//  TacheTableViewCell.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import RxSwift

class TacheTableViewCell: CustomTableViewCell {

    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: TaskDoneDelegate?
    weak var taskClickedPublishSubject: PublishSubject<Task>!
    
    var taskModel: TaskCellModel? {
        didSet {
            titleLabel.text = taskModel?.titleLabel
            dateLabel.text = taskModel?.dateLabel
            roundedBackgroundView.backgroundColor = taskModel?.backgroundColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedBackgroundView.layer.cornerRadius = 8
        roundedBackgroundView.layer.masksToBounds = true
        
        self.height = 110
    }
    
    override func applyTheme() {
        super.applyTheme()
        
        let t = AppPreferences.sharedInstance.theme!
        
        contentView.backgroundColor = t.backgroundColor
        
        dateLabel.textColor = t.backgroundColor
        titleLabel.textColor = t.backgroundColor
        
        bgView.backgroundColor = t.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        taskClickedPublishSubject.onNext(taskModel!.task)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

}
