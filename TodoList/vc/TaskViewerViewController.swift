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
import RxSwift

class TaskViewerViewController: UIViewController {
    
    var bulletinManager: BulletinManager?
    var viewModel: TasksViewerViewModel = TasksViewerViewModel()
    var taskDataSource: RxTasksViewerDataSource!
    var disposeBag = DisposeBag()
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var taskTableView: TacheTableView!
    @IBOutlet weak var selectListCollectionView: SelectListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectListCollectionView.listDelegate = self
        
        taskDataSource = RxTasksViewerDataSource(taskTableView.taskClicked)
        
        self.populateTableView()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AppPreferences.sharedInstance.firstLaunch {
            AppPreferences.sharedInstance.firstLaunch = false
            self.askNotificationPermission()
        }
        
        selectListCollectionView.lists = ListManager.getAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloadData()
    }
    
    func populateTableView() {
        let observable = viewModel.sections.asObservable()
        
        observable.bind(to: taskTableView.rx.items(dataSource: taskDataSource)).disposed(by: disposeBag)
        
        // When the user delete a task
        taskTableView.taskDeleted.subscribe { (indexPathEvent) in
            UIView.transition(with: self.taskTableView, duration: 0.2,options: .transitionCrossDissolve, animations: {
                self.viewModel.delete(indexPath: indexPathEvent.element!)
            })
            
        }.disposed(by: disposeBag)
        
        taskTableView.taskClicked.subscribe(makeTaskDone(_:)).disposed(by: disposeBag)
    }
    
    func makeTaskDone(_ taskEvent: Event<Task>) {
        log.info("Task \(taskEvent.element!.taskName) deleted")
        
        taskEvent.element?.done = true
        UIView.transition(with: taskTableView, duration: 0.2,options: .transitionCrossDissolve, animations: {
            self.viewModel.removeFromCurrentData(task: taskEvent.element!)
            self.taskTableView.reloadData()
        })
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
                DispatchQueue.main.async {
                    self.bulletinManager?.dismissBulletin()
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
        self.taskTableView.sections = SectionManager.createSections()
    }
}

extension TaskViewerViewController: FilterListDelegate {
    func printAllTask() {
        //sections = SectionManager.createSections()
    }
    
    func removeAll() {
        //sections = SectionManager.createEmptySections()
    }
    
    func addFilter(list: List) {
        //sections = SectionManager.merge(s1: sections, s2: SectionManager.createSectionWith(filter: list))
    }
    
    func removeFilter(list: List) {
        //sections = SectionManager.remove(filter: list, sections: sections)
    }
    
    
}

extension TaskViewerViewController: ThemeChangeProtocol {
    func themeDidChange(theme newTheme: Theme) {
        AppPreferences.sharedInstance.theme = newTheme
        //applyTheme()
    }
}


