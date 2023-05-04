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
    
    static var listenerThang = [ListenerRegistration]()
    
    static func setUserProfile(fullName: String, image: UIImage?, isJanitor: Bool, schoolCode: Int, completion: @escaping (Bool)-> Void) {
        guard AuthViewModel.isUserLoggedIn() else { print("💩 user not logged, cant set profile"); return }
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        let userId = AuthViewModel.getLoggedInUserId()
        let userEmail = AuthViewModel.getUserEmail()
        
        let doc = db.collection(C.users).document(userId)
        
        //        TODO: change deez to the constant file properties
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
                    }//downLoadURL
                }
            }//putData
        } else {
            completion(true)
        }
    }
    
    static func updateProfile(fullName: String?, profileImage: UIImage?, isJanitor: Bool?, schoolCode: Int?) async throws {
        
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database updateUserProfile() user aint logged in");  return }
        
        guard let currentUser = Auth.auth().currentUser?.uid else { print("🤡 database updateUserProfile() currentUser has no ID"); return }
        
        let db = Firestore.firestore()
        let doc = db.collection(C.users).document(currentUser)
        
        let userId = AuthViewModel.getLoggedInUserId()
        
        
        if let fullName {
            try await doc.setData([C.fullName: fullName], merge: true)
        }
        if let isJanitor {
            try await doc.setData([C.isJanitor: isJanitor], merge: true)
        }
        if let schoolCode {
            try await doc.setData([C.schoolCode: schoolCode], merge: true)
        }
        if let profileImage {
            
            guard let dataImage = profileImage.jpegData(compressionQuality: 0.1) else { print("💋 dataImage is Homo updateProfile() database"); return }
            
            let storageRef = Storage.storage().reference()
            
            let path = "\(C.images)/\(UUID().uuidString).jpeg"
            let fileRef = storageRef.child(path)
            
            let _ = try await fileRef.putDataAsync(dataImage)
            
            let url = try await fileRef.downloadURL()
            
            try await doc.setData([C.image: url.absoluteString ], merge: true)
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
    
    static func sendTask(todo: Todo, image: UIImage?) async throws {
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        
        let doc = db.collection(C.tasks).document()
        
        try doc.setData(from: todo) { error in // i dont think i need this completion
            if let error {
                print("😵‍💫 error sendTask(): \(error)")
            }
            
            if let image {
            
            guard let dataImage = image.jpegData(compressionQuality: 0.1) else { print("😼 sendTask() dataService image.JpegData"); return }
            
            let path = "\(C.images)/\(UUID().uuidString).jpeg"
            let fileRef = storageRef.child(path)
            
                Task {
                    do {
                        let _ =  try await fileRef.putDataAsync(dataImage)
                        let url = try await fileRef.downloadURL()
                        
                        //maybe move the setData to outside the Task by making a var url outside the task to load the url to before setData
                        try await doc.setData([C.imageUrl: url.absoluteString], merge: true)
                        
                    } catch {
                        print("🎃 dataService image putDataAsync : \(error)")
                    }
                }
            }
        }
    }
    
    static func gitTasksInit() async throws -> [Todo] {
        
        print("👅 databaseService gitTasksInit() run ")

        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return [] }
        
        let db = Firestore.firestore()
        
        let collection = db.collection(C.tasks).order(by: "timestamp")//.order(by: "timestamp")
     
        let docs = try await collection.getDocuments()
        
        var todos = [Todo]()
        
        for doc in docs.documents {
            let todo = try doc.data(as: Todo.self)
            
            todos.append(todo)
        }
        
        return todos
    }
    
    static func gitTasks(completion: @escaping (_ todos: [Todo])-> Void) {
        print("🎃 databaseService gitTasks() run ")
        guard AuthViewModel.isUserLoggedIn() else { print("💩 database gitCurrentUserModel() user aint logged in");  return }
        
        let db = Firestore.firestore()
        let collection = db.collection(C.tasks).order(by: "timestamp")//.order(by: "timestamp")
        
        let listener = collection.addSnapshotListener { snapshot, error in
            print("🎃 databaseService gitTasks() LISTENER run ")

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
    
//    static func detachTaskListeners() {
//        taskListener.forEach { listener in
//            listener.remove()
//        }
//    }
    
    static func deleteAccount() async throws {
        guard AuthViewModel.isUserLoggedIn() else { print("💩 user not logged, cant set profile"); return }
        guard let currentUser = Auth.auth().currentUser else { print("🦾 currentUser deleteAccout() dataBase"); return}
        
        try await currentUser.delete()
    }
}


