//
//  NotificationHandler.swift
//  drinkit
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationHandler: NSObject {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    static let shared = NotificationHandler()
    private var actions = [String: ()->Void]()
    
    
    override private init() {
        super.init()
        // notificationCenter.delegate = self
    }
    
    
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
    func sendNotificationWith(title: String, subtitle: String, body: String, timeDelay: TimeInterval, repeats: Bool, categoryIdentifier: String?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        
        if let id = categoryIdentifier {
            content.categoryIdentifier = id
        }
        
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
        createNotificationCategoryWith(identifier: "fooAction", title: "Foo Action") {
            print("Foo Action Called")
        }
        
        sendNotificationWith(
            title: "Default",
            subtitle: "Some Notification",
            body: "This is a default notification",
            timeDelay: 10,
            repeats: false,
            categoryIdentifier: "fooAction"
        )
    }
    
    
    func deleteAllScheduledNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    
    func createNotificationCategoryWith(identifier: String, title: String, action: @escaping ()->Void) {
        let notificationAction = UNNotificationAction(identifier: identifier, title: title, options: [])
        actions[identifier] = action
        
        let category = UNNotificationCategory(
            identifier: identifier,
            actions: [notificationAction],
            intentIdentifiers: [],
            options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
}


//extension NotificationHandler: UNUserNotificationCenterDelegate {
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let actionIdentifier = response.actionIdentifier
//
//        if let completion = actions[actionIdentifier] {
//            completion()
//        }
//    }
//
//}




