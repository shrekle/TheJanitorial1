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
    var fullName: String?
    var todo: String?
    var eta: String?
    var custom: String?
    var imageUrl: String?
}
