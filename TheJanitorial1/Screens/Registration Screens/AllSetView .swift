//
//  AllSetView.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 3/15/23.
//

import SwiftUI

struct AllSetView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
   
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("onboardingAllSetUp")
            
            Text("nice!")
                .font(.largeTitle)
                .padding(.top, 32)
            
            Text("Janitor, get to scrubbing that toilet!!!")
                .font(.callout)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                loginVM.loginStatus = .isloggedIn
                loginVM.isRegistrationSheetPresented = false
            } label: {
                Text("Continue over to cracking the whip on the janitor!!!")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }// Vstack
        .padding()
    }// BODY
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AllSetView()
    }
}
