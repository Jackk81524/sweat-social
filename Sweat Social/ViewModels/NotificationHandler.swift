//
//  NotificationHandler.swift
//  Sweat Social
//
//  Created by Luke Chigges on 4/02/24.
//

import Foundation
import SwiftUI
import UserNotifications

func requestNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            print("Notification permission granted.")
        } else if let error = error {
            print("Error requesting notifications permissions: \(error)")
        }
    }
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Other setup code
    UIApplication.shared.registerForRemoteNotifications()
    return true
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle foreground notification
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle background notification
        completionHandler()
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var notificationDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set this object as the notification center's delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate
        
        // Request notification permission
        requestNotifications()
        
        // Register for remote notifications
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Error requesting notifications permissions: \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
}

// This function is for testing purposes only
func scheduleLocalNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Test Notification"
    content.body = "This is a test notification."
    content.sound = UNNotificationSound.default

    // Trigger in 5 seconds
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    // Create the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // Add request to UNUserNotificationCenter
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling local notification: \(error)")
        }
    }
}
