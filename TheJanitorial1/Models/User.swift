//
//  User.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/16/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var image: String?
}

//struct AuthDataResultModel {
//    let uid: String
//    let email: String?
//    let photo: String?
//    let phone: String?
//
//    // it knows what type User is because it comes from the firebaseAuth sdk
//    init(user: User) {
//        self.uid = user.uid
//        self.email = user.email
//        self.photo = user.photoURL?.absoluteString
//        self.phone = user.phoneNumber
//    }
//}
