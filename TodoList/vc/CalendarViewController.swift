//
//  CalendarViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var dateTaskTableView: DateTaskTableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        calendar.delegate = self
        
    }
}

extension CalendarViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        
        dateLabel.text = formatter.string(from: date)
        dateTaskTableView.tasks = TaskManager.get(at: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return TaskManager.numberOfeventsForDate(date: date) == 0 ? nil : UIColor(hex: "#3498db")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return TaskManager.numberOfeventsForDate(date: date) == 0 ? nil : UIColor(hex: "#FFF")
    }
}
