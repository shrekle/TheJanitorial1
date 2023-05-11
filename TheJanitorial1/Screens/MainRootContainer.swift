//
//  MainRootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI

@MainActor
struct MainRootContainer: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var taskListVM: TaskListViewModel
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            
            Color(.lightGray)
                .opacity(0.05)
                .ignoresSafeArea()
            
            VStack {
                switch loginVM.loginStatus {
                case .isloggedIn:
                    LoggedInRootContainer()
                case .isloggedOut:
                    LoginScreen()
                }
            }
        }
        .onChange(of: scenePhase) { newPhase  in
            if newPhase == .active {
//                Task{
//                        try await taskListVM.gitTasks()
//                    }
                print("active")
            } else if newPhase == .inactive {
                print("inactive")
            } else if newPhase == .background {
                print("background")
                      UIApplication.shared.applicationIconBadgeNumber = 0
//                taskListVM.taskListCleanUp()
            }
        }
    }
}

struct MainRootContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainRootContainer()
            .environmentObject(LoginViewModel())
    }
}
