//
//  ViewModel.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import Foundation
import FirebaseAuth

enum currentStatus: Int {
    case isloggedIn = 0
    case isloggedOut = 1
}

class LoginViewModel: ObservableObject {
    
    @Published var loginStatus: currentStatus = .isloggedOut
    @Published var isRegistrationSheetPresented = false
    
}
