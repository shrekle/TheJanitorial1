//
//  RootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI

enum currentStatus: Int {
    case loggedIn = 0
    case loggedOut = 1
}

struct RootContainer: View {
    
    @EnvironmentObject var model: ViewModel
    
    @State var isLoggedIn = AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        ZStack {
            
            Color(.lightGray)
                .opacity(0.05)

            VStack {
                
                if isLoggedIn {
                    TaskListScreen()
                } else {
                    LoginScreen(isLoggedIn: $isLoggedIn)
                }
//                switch status {
//                case true:
//                    TaskListScreen()
//                case false:
//                    LoginScreen()
//                }
            }
        }
    }
}

struct RootContainer_Previews: PreviewProvider {
    static var previews: some View {
        RootContainer()
    }
}
