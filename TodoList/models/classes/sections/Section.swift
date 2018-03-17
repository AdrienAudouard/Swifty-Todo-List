//
//  Section.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

struct Section {
    var header: String
    var items: [Item]
}

extension Section: AnimatableSectionModelType {
    typealias Item = Task
    
    var identity: String {
        return header
    }
    
    init(original: Section, items: [Section.Item]) {
        self = original
        self.items = items
    }
}
