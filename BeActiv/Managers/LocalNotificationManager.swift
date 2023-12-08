//
//  LocalNotificationManager.swift
//  BeActiv
//
//  Created by Maryam Kaveh on 8/10/1402 AP.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    
    private init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if let error {
                #if DEBUG
                print(error)
                #endif
            }
        }
    }
    
    func sendNotif(title: String) {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = "Welldone!🏅"
        content.subtitle = "You reached your \(title) Goal today!💪"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
