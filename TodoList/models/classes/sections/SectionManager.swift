//
//  SectionManager.swift
//  TodoList
//
//  Created by Adrien Audouard on 15/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

class SectionManager {
    class func createSectionWithDoneTasks() -> [Section]{
        let tasks = TaskManager.getAllDone()
        
        let dic = Dictionary(grouping: tasks, by: {$0.dateFormated})
        var sections = [Section]()
        
        for (date, dateTasks) in dic {
            sections.append(Section(header: date, items: dateTasks))
        }
        
        return sections
    }
    
    class func createSectionWith(filter: List) -> [Section]{
        let sections = createSections()
        
        for var s in sections {
            _ = s.items.remove(handler: { $0.list.id != filter.id })
        }
        
        print("count with filter \(sections.count)")
        
        return sections
    }
    
    class func merge(s1: [Section], s2: [Section]) -> [Section] {
        if s1.count == 0 {return s2}
        if s2.count == 0 {return s1}
        
        var newSections = [Section]()
        
        for i in 0 ..< s1.count {
            var s = Section(header: s1[i].header, items: [Task]())
            
            s.items.append(contentsOf: s1[i].items)
            s.items.append(contentsOf: s2[i].items)
            
            newSections.append(s)
        }
        
        return newSections
    }
    
    class func remove(filter: List, sections: [Section]) -> [Section] {
        for var s in sections {
            _ = s.items.remove(handler: { $0.list.id == filter.id })
        }
        
        return sections
    }
    
    class func createEmptySections() -> [Section] {
        var sections = [Section]()
        var d = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_gb")
        
        sections.append(Section(header: "Today", items: [Task]()))
        
        for _ in 0...5 {
            d = d.addingTimeInterval(60 * 60 * 24)
            
            sections.append(Section(header: formatter.string(from: d).capitalizingFirstLetter(), items: [Task]()))
        }
        
        sections.append(Section(header: "Later", items: [Task]()))
        
        return sections
    }
    
    class func createSections() -> [Section] {
        var sections = [Section]()
        var d = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_gb")
        
        sections.append(Section(header: "Today", items: TaskManager.get(at: d)))
        
        for _ in 0...5 {
            d = d.addingTimeInterval(60 * 60 * 24)
            
            sections.append(Section(header: formatter.string(from: d).capitalizingFirstLetter(), items: TaskManager.get(at: d)))
        }
        
        sections.append(Section(header: "Later", items: TaskManager.after(date: d)))
        
        return sections
    }
}
