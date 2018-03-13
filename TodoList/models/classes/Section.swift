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
