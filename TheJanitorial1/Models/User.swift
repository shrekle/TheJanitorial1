//
//  User.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/16/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var image: String?
}
