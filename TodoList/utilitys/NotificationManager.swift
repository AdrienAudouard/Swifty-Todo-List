//
//  NotificationManager.swift
//  TodoList
//
//  Created by Adrien Audouard on 04/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let sharedInstance = NotificationManager()
    
    var center: UNUserNotificationCenter
    
    private init() {
        center = UNUserNotificationCenter.current()
    }
    
    func createNotification(_ task: Task) {
        guard task.date.timeIntervalSince(Date()) > 0 else {
            return
        }
        
        let content = UNMutableNotificationContent()
        
        content.body = task.taskName
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: task.date.timeIntervalSince(Date()), repeats: false)
        let request = UNNotificationRequest.init(identifier: "\(task.id)", content: content, trigger: trigger)

        center.add(request) { (error) in
            print(error ?? "")
        }
    }
    
    func removeNotification(_ task: Task) {
        center.removePendingNotificationRequests(withIdentifiers: ["\(task.id)"])
        
    }
    
    func notHavePermission(_ handler: @escaping () -> Void) {
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .denied || settings.authorizationStatus == .notDetermined {
                DispatchQueue.main.async {
                    handler()
                }
            }
        }
    }
}
