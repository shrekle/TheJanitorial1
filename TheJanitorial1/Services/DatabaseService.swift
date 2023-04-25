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

//TODO: deal with the listeners
//TODO: learn to send notifications for the janitor side of the app

final class DatabaseService {
    
    static var taskListener = [ListenerRegistration]()
    
    static func setUserProfile(fullName: String, image: UIImage?, isJanitor: Bool, schoolCode: Int, completion: @escaping (Bool)-> Void) {
        guard AuthViewModel.isUserLoggedIn() else { print("💩 user not logged, cant set profile"); return }
        
        print("😍 database setUserProfile testing, passed the isUserLogged in guard check : \(fullName)")
        
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

    static func sendTask(todo: Todo) async throws {
        
        let db = Firestore.firestore()
        
        let doc = db.collection(C.tasks).document()
        
        try doc.setData(from: todo) { error in // i dont think i need this completion
            if let error {
                print("😵‍💫 error sendTask(): \(error)")
            }
        }
    }
    
    static func gitTasks(completion: @escaping (_ todos: [Todo])-> Void) {
        
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return }
        
        let db = Firestore.firestore()
        let collection = db.collection(C.tasks).order(by: "timestamp")//.order(by: "timestamp")
        
        let listener = collection.addSnapshotListener { snapshot, error in
            
            guard let snapshot else { print("👻 Error fetching snapshot: \(String(describing: error))"); return }

            var todos = [Todo]()

             for document in snapshot.documents {
                 do {
                     let todo = try document.data(as: Todo.self)
                     todos.append(todo)
                 } catch {
                     print("👻 Error decoding Todo object: \(error)")
                 }
             }
            completion(todos)
         }//listener
        taskListener.append(listener)
    }
    
   static func deleteTask(todoID: String) {
        
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return }
        
        let db = Firestore.firestore()
                
        let userQueer = db.collection(C.tasks).document(todoID)
       
       userQueer.delete()
    }
    
    static func detachTaskListeners() {
        taskListener.forEach { listener in
            listener.remove()
        }
     }
}


