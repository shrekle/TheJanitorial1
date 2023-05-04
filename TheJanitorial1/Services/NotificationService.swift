//
//  NotificationService.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 5/4/23.
//

import SwiftUI

class NotificationService {
    
   static func showNotification() async throws {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "The Janitorial"
        content.body = "NEW TO DOO-DOO 💩!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        try await center.add(request)
    }
}
