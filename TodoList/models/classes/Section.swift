//
//  Section.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

class Section {
    var title: String
    var cell: [Task]
    var headerHeight: CGFloat
    
    init(title: String, height: CGFloat) {
        self.title = title
        self.headerHeight = height
        
        cell = [Task]()
    }
    
    class func createSectionWith(filter: List) -> [Section]{
        let sections = createSections()
        
        for s in sections {
            _ = s.cell.remove(handler: { $0.id != filter.id })
        }
        
        return sections
    }
    
    class func merge(s1: [Section], s2: [Section]) -> [Section] {
        if s1.count == 0 {return s2}
        if s2.count == 0 {return s1}
        
        var newSections = [Section]()
        
        for i in 0 ..< s1.count {
            let s = Section(title: s1[i].title, height: s1[i].headerHeight)
            
            s.cell.append(contentsOf: s1[i].cell)
            s.cell.append(contentsOf: s2[i].cell)
            
            newSections.append(s)
        }
        
        return newSections
    }
    
    class func remove(filter: List, sections: [Section]) -> [Section] {
        for s in sections {
            _ = s.cell.remove(handler: { $0.id == filter.id })
        }
        
        return sections
    }
    
    class func createSections() -> [Section] {
        var sections = [Section]()
        var d = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_gb")
        
        sections.append(Section(title: "Today", height: 60))
        sections.last?.cell = TaskManager.get(at: d)
        
        for _ in 0...5 {
            d = d.addingTimeInterval(60 * 60 * 24)
            
            sections.append(Section(title: formatter.string(from: d).capitalizingFirstLetter(), height: 60))
            sections.last?.cell = TaskManager.get(at: d)
        }
        
        sections.append(Section(title: "Later", height: 60))
        sections.last?.cell = TaskManager.after(date: d)
        
        return sections
    }
}
