//
//  LoggedInRootContainer.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 4/13/23.
//

import SwiftUI

struct LoggedInRootContainer: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
     private var isJanitor: Bool { //might have to make it a state prop to see if when it flips to true it triggers
        loginVM.currentUser.isJanitor ?? false
    }
    
    var body: some View {
        switch loginVM.currentUser.isJanitor {
        case true:
            JanitorHomeScreen()
        case false:
            StaffHomeScreen()
//        case nil:
//            ProgressView()
        default:
            ProgressView()
        }
    }
}

struct LoggedInRootContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInRootContainer()
    }
}
