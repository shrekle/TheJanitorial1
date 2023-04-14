//
//  RegistrationViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import Foundation

@MainActor
final class RegistrationViewModel: ObservableObject {
    
    @Published var loginStatus: currentStatus = .isloggedOut
    @Published var isRegistrationSheetPresented = false
    
    static func signUp(email: String, password: String) async throws {
        guard !email.isEmpty, !password.isEmpty else { print("🤬 no email or password"); return }
        try await AuthViewModel.createUserWithEmail(email: email, password: password)
    }
}
