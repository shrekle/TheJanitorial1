//
//  MainRootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/22/23.
//

import SwiftUI

struct MainRootContainer: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
  
    var body: some View {
        ZStack {
            
            Color(.lightGray)
                .opacity(0.05)
                .ignoresSafeArea()
            
            VStack {
                switch loginVM.loginStatus {
                case .isloggedIn:
                    LoggedInRootContainer()
                case .isloggedOut:
                    LoginScreen()
                }
            }
        }
    }
}

struct MainRootContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainRootContainer()
            .environmentObject(LoginViewModel())
    }
}
