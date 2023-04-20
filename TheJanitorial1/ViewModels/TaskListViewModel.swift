//
//  TaskListVM.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import Foundation

@MainActor
final class TaskListViewModel: ObservableObject {
    
    @Published var currentUser = UserModel()
    @Published var tasks = [Todo]() // make task object
    @Published var isPresented = false
    
    init() {
        Task {
            do {
                try await gitTasks()
                try await gitCurrentUser()
            } catch {
                print("👁️ tasklistVM init(): \(error)")
            }
        }
    }
    
    func gitCurrentUser() async throws {
         currentUser = try await DatabaseService.gitCurrentUserModel()
        print("🥶 current user taskListVM : \(currentUser)")

    }
    
    func gitTasks() async throws {
        DatabaseService.gitTasks { todos in
            self.tasks = todos
        }
    }
    // have it throw maybe
    func gitSender(senderID: String) async throws -> UserModel {
        try await DatabaseService.gitSendertUserModel(senderID: senderID)
    }
}
