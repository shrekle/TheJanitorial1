//
//  Todo.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/27/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Todo: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var timestamp: Date?
    var userId: String?
    var fullName: String?
    var senderProfilePicUrl: String?
    var todo: String?
    var eta: String?
    var custom: String?
    var imageUrl: String?
    var janitorToken: String?
}
