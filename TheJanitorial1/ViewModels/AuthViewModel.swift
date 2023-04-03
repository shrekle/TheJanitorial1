//
//  AuthViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/15/23.
//

import Foundation
import FirebaseAuth

final class AuthViewModel {
    
    static func isUserLoggedIn()-> Bool {
        Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId()-> String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logOut() {
        try? Auth.auth().signOut()
    }
    
    static func getUserPhoneNumber()-> String {
        Auth.auth().currentUser?.phoneNumber ?? ""
    }
    
    static func getUserEmail()-> String {
        Auth.auth().currentUser?.email ?? ""
    }
}

///EMAIL CRAP
extension AuthViewModel {
    
    //    @discardableResult
    static func createUserWithEmail(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    //    @discardableResult
    static func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}





















































