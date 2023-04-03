//
//  SendTaskViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/1/23.
//

import Foundation

@MainActor
final class SendTaskViewModel: ObservableObject {
    
    @Published var user = UserModel()
    
    init() {
        Task {
            do {
                try await gitUser()
            }
        }
    }
    
    func gitUser() async throws {
        return self.user = try await DatabaseService.gitCurrentUserModel()
    }
}
