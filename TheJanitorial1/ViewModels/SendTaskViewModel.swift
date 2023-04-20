//
//  SendTaskViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import Foundation

@MainActor
final class SendTaskViewModel: ObservableObject {
    
    @Published var currentUser = UserModel()
    @Published var todo = Todo()
    
    init() {
        Task {
            do {
                try await gitCurrentUser()
            }
        }
    }
    
    func gitCurrentUser() async throws {
         currentUser = try await DatabaseService.gitCurrentUserModel()
    }
    //maybe pass the cyrrent user donw through a bnding to the sheet which is task container, which holds the task form
    func sendTask(todo: Todo) async throws {
        
        //only user one of deez guards
        guard currentUser.fullName != nil else { print("🥰 sentTaskVM sendTask(), currrentUser.fullName is nil"); return }
        guard currentUser.id != nil else { print("😶‍🌫️ sentTaskVM sendTask(), currrentUser.id is nil"); return }
        
        try await DatabaseService.sendTask(todo: todo, user: currentUser.fullName!)
    }
}
