//
//  RootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI

struct RootContainer: View {
    
    @EnvironmentObject var model: LoginViewModel
    
//    @State var user = UserModel()
    
    var body: some View {
        ZStack {
            
            Color(.lightGray)
                .opacity(0.05)

            VStack {
                switch model.loginStatus {
                case .isloggedIn:
                    StaffTaskHomeScreen()
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
