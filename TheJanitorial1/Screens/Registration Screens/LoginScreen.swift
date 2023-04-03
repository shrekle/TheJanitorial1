//
//  LoginScreen.swift
//  TheJanitorial1
//
//  Created by adrian garcia on 2/1/23.
//

import SwiftUI

/// use the tutorial from sean allen swiftUI form, it has all that i need to make the request form for teachers to fill out and send me with a task

struct LoginScreen: View {
    
    @EnvironmentObject var model: LoginViewModel
    
    @State private var emailTxtF = ""
    @State private var passwordTxtF = ""
    
//    @State private var isRegisterSheetPresented = false
    
//    TODO: inform user of error signing in, email or password dont match
    
    var body: some View {
        
        NavigationStack {    
                ZStack {
                Color(.lightGray)
                    .opacity(0.05)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TextField("Username/Email", text: $emailTxtF)
                        .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $emailTxtF))
                    
                    SecureField("Password", text: $passwordTxtF)
                        .textFieldStyle(CreateProfileTextfieldStyle(buttonText: $passwordTxtF))
                    
                    Button {
//                    TODO: verification process of signing in with the email and password
                        Task {
                            do {
                                try await model.signIn(email: emailTxtF, password: passwordTxtF)
                                // not too sure if this will execute even if sign in fails, with this new async await 
                                model.loginStatus = .isloggedIn
                            } catch {
                                print("💩 error signing up: \(error)")
                            }
                        }
                       
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
            .environmentObject(LoginViewModel())
    }
}
