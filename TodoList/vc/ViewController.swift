//
//  ViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 28/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import DateTimePicker
import IQKeyboardManagerSwift
import Spring
import BulletinBoard
import UserNotifications

class ViewController: UIViewController {
    
    var bulletinManager: BulletinManager?
    var sections: [Section]! {
        didSet {
            UIView.transition(with: taskTableView, duration: 0.2,options: .transitionCrossDissolve, animations: {
                self.taskTableView.sections = self.sections
                
            })
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var taskTableView: TacheTableView!
    @IBOutlet weak var selectListCollectionView: SelectListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chooseThemePopUp = ChooseThemePopUp(frame: self.view.bounds)
        chooseThemePopUp.delegate = self
        //view.addSubview(chooseThemePopUp)
        
        selectListCollectionView.listDelegate = self
        taskTableView.taskDelegate = self
        sections = [Section]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AppPreferences.sharedInstance.firstLaunch {
            AppPreferences.sharedInstance.firstLaunch = false
            self.askNotificationPermission()
        }
        
        selectListCollectionView.lists = ListManager.getAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //applyTheme()
        reloadData()
    }
    
    func applyTheme() {
        let t = AppPreferences.sharedInstance.theme!
        
        self.bgView.backgroundColor = t.backgroundColor
        self.tabBarController?.tabBar.barTintColor = t.navBarBackgroundColor
        self.tabBarController?.tabBar.tintColor = t.navBarItemColor
        
        self.taskTableView.applyTheme()
    }
    
    func askNotificationPermission() {
        let page = PageBulletinItem(title: "Push Notifications")
        page.image = UIImage(named: "NotificationPrompt")
    
        page.descriptionText = "Receive push notifications when a task must be done."
        page.actionButtonTitle = "Subscribe"
        page.alternativeButtonTitle = "Not now"
        
        page.actionHandler = { item in
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, _) in
                if !granted {
                    self.askNotificationPermission()
                }
            }
        }
        
        page.alternativeHandler = { item in
            item.manager?.dismissBulletin()
        }
        
        bulletinManager = BulletinManager(rootItem: page)
        
        bulletinManager?.backgroundViewStyle = .blurredDark
        
        bulletinManager?.prepare()
        bulletinManager?.presentBulletin(above: self)
    }
    
    @IBAction func manageListButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "InitListViewController", sender: nil)
    }
    func reloadData() {
        self.taskTableView.sections = Section.createSections()
    }
}

extension ViewController: TaskProtocol {
    func mustRemoveTask(task: Task) {
        TaskManager.remove(task)
        reloadData()
    }
    
    func newTaskCreated(task newTask: Task) {
        TaskManager.save(newTask)
        reloadData()
    }
}

extension ViewController: FilterListDelegate {
    func addFilter(list: List) {
        sections = Section.merge(s1: sections, s2: Section.createSectionWith(filter: list))
    }
    
    func removeFilter(list: List) {
        sections = Section.remove(filter: list, sections: sections)
    }
    
    
}

extension ViewController: ThemeChangeProtocol {
    func themeDidChange(theme newTheme: Theme) {
        AppPreferences.sharedInstance.theme = newTheme
        //applyTheme()
    }
}


