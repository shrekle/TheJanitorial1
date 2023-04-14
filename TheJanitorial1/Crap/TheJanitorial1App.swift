//
//  TheJanitorial1App.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI
import Firebase

@main
struct TheJanitorial1App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            MainRootContainer()
                .environmentObject(LoginViewModel())
                .environmentObject(SendTaskViewModel())
        }
    }
}


