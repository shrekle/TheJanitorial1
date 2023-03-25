//
//  RootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI

struct RootContainer: View {
    
    @EnvironmentObject var model: LoginViewModel
    
    
    var body: some View {
        ZStack {
            
            Color(.lightGray)
                .opacity(0.05)

            VStack {
                
//                if isLoggedIn {
//                    TaskListScreen()
//                } else {
//                    LoginScreen(isLoggedIn: $isLoggedIn)
//                }
                switch model.loginStatus {
                case .isloggedIn:
                    TaskListScreen()
                case .isloggedOut:
                    LoginScreen()
                }
            }
        }
    }
}

struct RootContainer_Previews: PreviewProvider {
    static var previews: some View {
        RootContainer()
            .environmentObject(LoginViewModel())
    }
}
