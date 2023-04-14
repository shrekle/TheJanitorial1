//
//  TaskListVM.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import Foundation


@MainActor
final class TaskListViewModel: ObservableObject {
    
    @Published var tasks = [Todo]() // make task object
    @Published var isPresented = false
    
    init() {
        Task {
            do {
                try await gitTasks()
            } catch {
                print("👁️ tasklistVM init(): \(error)")
            }
        }
    }
    
    func gitTasks() async throws {
        tasks =  try await DatabaseService.gitTasks()
    }
}
