//
//  AuthViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/15/23.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
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
    
    static func sendPhoneNumber(_ phoneNumber: String, completion: @escaping (Error?)-> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard error == nil else { print("error sending number: \(String(describing: error))"); return }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationId")
            
            DispatchQueue.main.async {
                completion(error)
            }
          }
    }
    
    static func verifyCode(verificationCode: String, completion: @escaping (Error?)-> Void) {
        let verificationId = UserDefaults.standard.string(forKey: "authVerificationId") ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}
