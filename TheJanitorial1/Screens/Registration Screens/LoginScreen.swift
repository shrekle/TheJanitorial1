//
//  LoginScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task
///
//TODO:  have the default screen be the log in if user is signed out, user is logged in then normal tasklist screen

struct LoginScreen: View {
    
    /// command+shift+F, to look up something in the entire project
    
    @EnvironmentObject var model: ViewModel
    
    @State private var nameTxtF = ""
    @State private var passwordTxtF = ""
    
//    @State private var isRegisterSheetPresented = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(.lightGray)
                    .opacity(0.05)
                    .ignoresSafeArea()
                
                VStack {
                    TextField("Username/Email", text: $nameTxtF)
                        .textFieldStyle(CreateProfileTextfieldStyle())
                    
                    TextField("Password", text: $passwordTxtF)
                        .textFieldStyle(CreateProfileTextfieldStyle())
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(OnboardingButtonStyle())
                    .padding(.bottom)
                    
                    Button("register") {
                        model.isRegistrationSheetPresented = true
                    }
                }
                .sheet(isPresented: $model.isRegistrationSheetPresented) {
                    RegistrationContainerView()
                        .presentationDragIndicator(.visible)
                        
                }
                .padding()
            }
        }
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
