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
import FirebaseAuth

final class DatabaseService {
    
    static func setUserProfile(fullName: String, image: UIImage?, isJanitor: Bool, schoolCode: Int, completion: @escaping (Bool)-> Void) {
        guard AuthViewModel.isUserLoggedIn() else { print("💩 user not logged, cant set profile"); return }
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        let userId = AuthViewModel.getLoggedInUserId()
        let userEmail = AuthViewModel.getUserEmail()
        
        let doc = db.collection(C.users).document(userId)
        
        doc.setData(["fullName": fullName, "email": userEmail, "isJanitor": isJanitor, "schoolCode": schoolCode])
        
        if let image {
            let dataImage = image.jpegData(compressionQuality: 0.1)
            
            guard let dataImage else {print("🤬 dataImage is homo"); return }
            
            let path = "\(C.images)/\(UUID().uuidString).jpeg"
            let fileRef = storageRef.child(path)
            
            fileRef.putData(dataImage, metadata: nil) { metaData, error in
                if error == nil && metaData != nil {
                    
                    fileRef.downloadURL { url, error in
                        guard error == nil, let url else { print("🦐 downloadURL ERROR: \(String(describing: error))"); return }
                        
                        doc.setData(["image": url.absoluteString], merge: true) { error in
                            if error == nil {
                                completion(true)
                            } else {
                                print("🤬 error gettin url Image: \(String(describing: error))")
                                completion(false)
                            }
                        }
                    }
                }
            }
        } else {
            completion(true)
        }
    }
    
    static func gitCurrentUserModel() async throws -> UserModel {
        
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return UserModel() }
        
        let db = Firestore.firestore()
        let currentUserID = AuthViewModel.getLoggedInUserId()
        
        var currentUser = UserModel()
        
        let userQueer = db.collection(C.users).document(currentUserID)
        
        let doc = try await userQueer.getDocument()
        
        currentUser = try doc.data(as: UserModel.self)
        
        return currentUser
    }
    
    static func sendTask(todo: Todo, user: String) async throws {
        
        let db = Firestore.firestore()
        
        let doc = db.collection(C.tasks).document()
        
        try doc.setData(from: todo) { error in // i dont think i need this completion
            if let error {
                print("😵‍💫 error sendTask(): \(error)")
            }
        }
        try await doc.setData(["fullName": user], merge: true)
    }
    
    static func gitTasks() async throws -> [Todo] {
        
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return [Todo]() }
        
        let db = Firestore.firestore()
        
        var todos = [Todo]()
        
        let snappy = try await db.collection(C.tasks).getDocuments()
        
        for doc in snappy.documents {
            let todo = try doc.data(as: Todo.self)
            todos.append(todo)
        }
        return todos
    }
}
  
