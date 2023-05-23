//
//  ViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import Foundation
import FirebaseAuth

enum currentStatus: Int {
    case isloggedIn = 0
    case isloggedOut = 1
}

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var currentUser = UserModel()
    @Published var loginStatus: currentStatus = .isloggedOut
    @Published var isRegistrationSheetPresented = false
    
    
    init() {
        isLoggedIn()
        Task {
            do {
                try await gitCurrentUser() // i changed the Taskk Do Catch to here
            } catch {
                print("👤 loginViewModel init(): \(error)")
            }
        }
    }

    func isLoggedIn() {
        
        switch AuthViewModel.isUserLoggedIn() {
        case true:
            loginStatus = .isloggedIn
        case false:
            loginStatus = .isloggedOut
        }
    }
    
    func signIn(email: String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else { print("🤬  no email or password"); return }
        try await AuthViewModel.signIn(email: email, password: password)
    }
    
    func gitCurrentUser() async throws {
        Task {
            do {
                self.currentUser = try await DatabaseService.gitCurrentUserModel()
            } catch {
                print("🤢 loginVM gitCurrentUser() catch : \(error)")
            }
        }
    }
}
