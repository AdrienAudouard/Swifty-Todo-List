//
//  tasksViewerViewModel.swift
//  TodoList
//
//  Created by Adrien Audouard on 15/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TasksViewerViewModel {
    var sections = Variable<[Section]>([])
    
    var disposeBag: DisposeBag
    
    init() {
        sections.value = [Section]()
        disposeBag = DisposeBag()
        
        TaskManager.newTask.delay(0.5, scheduler: MainScheduler.instance).subscribe { [unowned self] _ in
            self.createSection()
        }.disposed(by: disposeBag)
        
        createSection()
    }
    
    func createSection() {
        sections.value = SectionManager.createSections()
    }
    
    func delete(indexPath: IndexPath) {
        let taskToDelete = sections.value[indexPath.section].items[indexPath.row]
        TaskManager.remove(taskToDelete)

        _ = sections.value[indexPath.section].items.remove(handler: { $0 == taskToDelete })
    }
    
    func removeFromCurrentData(task: Task) {
        sections.value = SectionManager.createSections()
    }
}
