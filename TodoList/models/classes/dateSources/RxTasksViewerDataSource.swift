//
//  RxTasksViewerDataSource.swift
//  TodoList
//
//  Created by Adrien Audouard on 15/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import UIKit

class RxTasksViewerDataSource:  RxTableViewSectionedAnimatedDataSource<Section>{
    
    var taskClickedPublishSubject: PublishSubject<Task>
    
    init(_ taskClicked: PublishSubject<Task>) {
        self.taskClickedPublishSubject = taskClicked

        super.init(configureCell: { ds, tv, index, task in
            let cell = tv.dequeueReusableCell(withIdentifier: "TacheTableViewCell", for: index) as! TacheTableViewCell
            
            cell.taskModel = TaskCellModel(task)
            cell.selectionStyle = .none
            cell.taskClickedPublishSubject = taskClicked
            return cell
        })
    
        titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        canEditRowAtIndexPath = { _, _ in
            return true
        }
        
        canMoveRowAtIndexPath = {_, _ in
            return true
        }
        
    }
}
