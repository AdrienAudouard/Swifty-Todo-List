//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
import DateTimePicker

class AddTaskViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var taskNameButton: UITextField!
    @IBOutlet weak var listCollectionView: ListCollectionView!
    @IBOutlet weak var dateButton: UIButton!
    var picker: DateTimePicker?
    
    var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameButton.delegate = self
        taskNameButton.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked(_:)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
        
        listCollectionView.lists = ListManager.getAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskNameButton.becomeFirstResponder()
    }
    
    @objc func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        changeKeyboardSize(keyboardFrame.height - 50)
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        changeKeyboardSize(0)
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        _ = newTask()
        hide()
    }
    
    func changeKeyboardSize(_ size: CGFloat) {
        bottomConstraint.constant = size
        
        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hide() {
        let tbc = tabBarController as! RAMAnimatedTabBarController
        tbc.setSelectIndex(from: 2, to: 1)
    }
    
    func newTask() -> Bool{
        guard listCollectionView.selectedList != nil else {
            alert(title: "Error", message: "The task must be in a list", button: "Ok")
            return false
        }
        
        if taskNameButton.text?.count != 0 {
            let t = Task.init(taskNameButton.text!, date: selectedDate, list: listCollectionView.selectedList!)
            print("new task: \(t)")
            TaskManager.save(t)
        }
        
        return true
    }
    
    @IBAction func datePickerButtonPressed(_ sender: Any) {
        taskNameButton.resignFirstResponder()
        
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 360)
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Good !"
        
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = false
        picker.dateFormat = "hh:mm dd/MM/YYYY"
        picker.includeMonth = true
        picker.completionHandler = { date in
            self.selectedDate = date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"
            var d = formatter.string(from: date)
            d = d.prefix(1).uppercased() + d.dropFirst()
            
            formatter.dateFormat = "HH:mm"
            d = "\(d) at \(formatter.string(from: date))"
            
            self.dateButton.setTitle(d, for: .normal)
            
            self.taskNameButton.becomeFirstResponder()
        }
        
        picker.dismissHandler = {
            self.taskNameButton.becomeFirstResponder()
        }
        
        self.picker = picker
        print((self.picker?.frame.size.height)!)
        changeKeyboardSize(300)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        hide()
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if newTask() {
            hide()
            return true
        } else {
            return false
        }
    }
}
