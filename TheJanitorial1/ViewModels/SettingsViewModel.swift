//
//  SettingsViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/26/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func updateUserProfile(fullName: String?, profileImage: UIImage?, isJanitor: Bool?, schoolCode: Int?) async throws {
        try await DatabaseService.updateProfile(fullName: fullName, profileImage: profileImage, isJanitor: isJanitor, schoolCode: schoolCode)
    }
}
