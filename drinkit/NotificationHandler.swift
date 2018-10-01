//
//  NotificationHandler.swift
//  drinkit
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationHandler {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    static let shared = NotificationHandler()
    
    
    private init() {}
    
    
    /// Request authorization for send local notifications
    func requestAuthorization(completion: @escaping (Bool, Error?)->Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (wasAuthorized, error) in
            completion(wasAuthorized, error)
        }
    }
    
    
    /// Add local notification to notification center
    ///
    /// - Parameters:
    ///   - title: Title for notification
    ///   - subtitle: Subtitle for notification
    ///   - body: Notification message
    ///   - timeDelay: Delay to trigger message
    ///   - repeats: Trigger repeat status
    func sendNotificationWith(title: String, subtitle: String, body: String, timeDelay: TimeInterval, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeDelay, repeats: repeats)
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (err) in
            guard let error = err else {
                print("Notification Scheduled")
                return
            }
            
            print("Error to send notification", error)
        }
        
    }
    
    
    /// Send notification with default values
    func sendDefaultNotification() {
        sendNotificationWith(
            title: "Default",
            subtitle: "Some Notification",
            body: "This is a default notification",
            timeDelay: 10,
            repeats: false
        )
    }
    
    
    func deleteAllScheduledNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
}
