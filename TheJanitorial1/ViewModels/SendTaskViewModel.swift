//
//  SendTaskViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import SwiftUI

@MainActor
final class SendTaskViewModel: ObservableObject {
    
    @Published var currentUser = UserModel()
    @Published var todo = Todo()
    @Published var token: String? // this might not work or be need
    
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
    
    func sendTask(todo: Todo, image: UIImage?) async throws {
        guard currentUser.fullName != nil else { print("🥰 sentTaskVM sendTask(), currrentUser.fullName is nil"); return }
        
        try await DatabaseService.sendTask(todo: todo, image: image)
    }
}
