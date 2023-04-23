//
//  TaskListVM.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import Foundation

@MainActor
class TaskListViewModel: ObservableObject {
    
    @Published var currentUser = UserModel()
    @Published var tasks = [Todo]() // make task object
    @Published var taskToRemove = Todo()
    @Published var senders = [UserModel]()// maybe make this a set to avoid duplicates
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
    }
    
    func gitTasks() async throws {
        DatabaseService.gitTasks { todos in
            
            Task {
                do {
                    try await self.gitSender(taskies: todos)
                    self.tasks = todos
                } catch {
                    print("👻 gitTasks() TaskListVM : \(error)")
                }
            }
        }
    }
    
    func gitSender(taskies: [Todo]) async throws {
        var senderArray = [UserModel]()

        taskies.forEach { task in
            Task {
                do {
                    let sender = try await DatabaseService.gitSendertUserModelAsync(senderID: task.userId!)
                      senderArray.append(sender)
                    self.senders = senderArray // if this is inside the loop then why does it matter if i put it in or outside of the do block
                } catch {
                    print("😽 gitSender() TaskListVM : \(error)")
                }
            }//Task
        }//forEach
    }
    
    func searchForUser(senderID: String)-> UserModel? {

        for sender in senders {
            if sender.id == senderID {
                return sender
            }
        }
        return nil
    }
    
    func deleteTask(todoID: String) {
        DatabaseService.deleteTask(todoID: todoID)
    }
}
