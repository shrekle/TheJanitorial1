//
//  SettingsViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/26/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    @Published var currentUser = UserModel()
    @Published var isLoggedIn = false
    
    init() {
        Task{
            do {
                try await gitCurrentUserModel()
            } catch {
                print("🦷 gitCurrentUser() settingsVM : \(error)")
            }
        }
    }
    
    func isUserLoggedIn() {
       isLoggedIn =  AuthViewModel.isUserLoggedIn()
    }
    
    func updateUserProfile(fullName: String?, profileImage: UIImage?, isJanitor: Bool?, schoolCode: Int?) async throws {
        try await DatabaseService.updateProfile(fullName: fullName, profileImage: profileImage, isJanitor: isJanitor, schoolCode: schoolCode)
    }
    
    func gitCurrentUserModel() async throws {
        currentUser = try await DatabaseService.gitCurrentUserModel()
    }
    
    func logOut() {
        AuthViewModel.logOut()
    }
    
    func deleteAccount() async throws {
        try await DatabaseService.deleteAccount()
    }
    
}
