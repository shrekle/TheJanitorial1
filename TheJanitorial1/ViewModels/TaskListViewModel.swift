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
    @Published var taskToRemove = Todo()
    @Published var senders = [UserModel]()// maybe make this a set to avoid duplicates
    @Published var isPresented = false
    
    init() {
        Task {
            do {
                try await gitCurrentUser()
                try await gitTasks()
            } catch {
                print("👁️ tasklistVM init(): \(error)")
            }
        }
    }
    
    func gitCurrentUser() async throws {
        currentUser = try await DatabaseService.gitCurrentUserModel()
    }
   
    func gitTasksInit() async throws {
        print("🦷 gitTasksInit() taskListVM")
        tasks = try await DatabaseService.gitTasksInit()
    }
    
    func gitTasks() async throws {
        print("💋 gitTasks() taskListVM")
        
        DatabaseService.gitTasks { todos in
            self.tasks = todos
        }
//         try await withCheckedThrowingContinuation({ continuation in
//            DatabaseService.gitTasks { tasks in
//                self.tasks = tasks
//                try? await NotificationService.showNotification()
//                continuation.resume(returning: ())
//            }
//        })
    }

    func taskIntoUserModel(task: Todo)-> UserModel {
       return  UserModel(fullName: task.fullName, image: task.senderProfilePicUrl)
    }
    
    func deleteTask(todoID: String) {
        DatabaseService.deleteTask(todoID: todoID)
    }
    
    func taskListCleanUp() {
        DatabaseService.detachTaskListeners()
    }
}
