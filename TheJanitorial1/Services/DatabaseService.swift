//
//  DatabaseService.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class DatabaseService {
    
    static func setUserProfile(fullName: String, image: UIImage?, isJanitor: Bool, schoolCode: Int, completion: @escaping (Bool)-> Void) {
        guard AuthViewModel.isUserLoggedIn() else { print("💩 user not logged, cant set profile"); return }
        
        let db = Firestore.firestore() // this needs to be here since its a static func, cant be a class property
        let storageRef = Storage.storage().reference()
        
        let userId = AuthViewModel.getLoggedInUserId()
        let userEmail = AuthViewModel.getUserEmail()
        
        let doc = db.collection("users").document(userId)
        
        doc.setData(["fullName": fullName, "email": userEmail, "isJanitor": isJanitor, "schoolCode": schoolCode])
        
        if let image {
            let dataImage = image.jpegData(compressionQuality: 0.1)
            
            guard let dataImage else {print("🤬 dataImage is homo"); return }
            
            let path = "images/\(UUID().uuidString).jpeg"
            let imageRef = storageRef.child(path)
            
            imageRef.putData(dataImage) { metaData, error in
                if error == nil && metaData != nil {
                    doc.setData(["image": path], merge: true) { error in
                        if error == nil {
                            completion(true)
                        } else {
                            print("🤬 error putting data Image: \(String(describing: error))")
                            completion(false)
                        }
                    }
                }
            }
        } else {
            completion(true)
        }
    }
}
