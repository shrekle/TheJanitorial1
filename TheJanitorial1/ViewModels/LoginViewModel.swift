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
class LoginViewModel: ObservableObject {
    
    @Published var loginStatus: currentStatus = .isloggedOut
    @Published var isRegistrationSheetPresented = false
    
    func signIn(email: String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else { print("🤬  no email or password"); return }
        try await AuthViewModel.signIn(email: email, password: password)
    }
    
}
