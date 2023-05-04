//
//  TheJanitorial1App.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct TheJanitorial1App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainRootContainer()
                .environmentObject(LoginViewModel())
                .environmentObject(SendTaskViewModel())
                .environmentObject(TaskListViewModel())
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    let gcmMessageIDKey = "gcm.message_id"
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        FIRMessaging.messaging
//    }
//}

