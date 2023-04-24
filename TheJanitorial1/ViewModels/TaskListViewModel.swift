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
                try await somehting()
                try await gitCurrentUser()
                try await gitSenderInit()
            } catch {
                print("👁️ tasklistVM init(): \(error)")
            }
        }
    }
    
    func gitCurrentUser() async throws {
        currentUser = try await DatabaseService.gitCurrentUserModel()
    }
    ///i need a func that has both the git func and the git sender and executes them one after the other synchronously , for a more consistent result
    
    func somehting() async throws {
        
        let tasks = await gitTasks()
        
        try await gitSender(taskies: tasks)
        
        self.tasks = tasks
    }
    
    func gitTasks() async -> [Todo] {
        return await withCheckedContinuation({ continuation in
            DatabaseService.gitTasks { todos in
                continuation.resume(returning: todos)
            }
        })
    }
    
    
//    self.tasks = todos
                
    //            Task {
    //                do {
    //                    try await self.gitSender(taskies: self.tasks)
    //                } catch {
    //                    print("👻 gitTasks() TaskListVM : \(error)")
    //                }
    //            }
    
    func gitSenderInit() async throws {
        
        var senderArray = [UserModel]()

        tasks.forEach { task in
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
    
    func gitSender(taskies: [Todo]) async throws {
        var senderArray = [UserModel]()

        taskies.forEach { task in
            Task {
                do {
                    let sender = try await DatabaseService.gitSendertUserModelAsync(senderID: task.userId!)
                      senderArray.append(sender)
                } catch {
                    print("😽 gitSender() TaskListVM : \(error)")
                }
            }//Task
        }//forEach
        self.senders = senderArray // if this is inside the loop then why does it matter if i put it in or outside of the do block

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
