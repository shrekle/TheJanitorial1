//
//  AppDelegate.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/21/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // one of deez two, not sure whats better
//    @EnvironmentObject var sendTaskVM: SendTaskViewModel
//    var token: String?


    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            if let error {
                print("🦐 error in appDelegate center.request : \(error)")
            }
        }
        
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//        } else {
//            let settings: UIUserNotificationSettings =
//            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
        
        application.registerForRemoteNotifications()
        
        return true
    } // func
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
// this is the registration token
      let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        
        //only ones of deez will be needed, not sure which one would be more legit
//        self.token = fcmToken
//        sendTaskVM.token = fcmToken// ithink i was trying this out but dont need it nomore and it didnt work
        
        print("Device token: ", deviceToken) // This token can be used for testing notifications on FCM
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

//    print(userInfo)

    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
      
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }

//    print(userInfo)

    completionHandler()
  }
}
