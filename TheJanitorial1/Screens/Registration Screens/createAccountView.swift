//
//  createAccountView.swift
//  chatAppCWC
//
//  Created by adrian garcia on 3/15/23.
//

import SwiftUI
import Combine

struct createAccountView: View {
    
    @Binding var currentStep: registrationStep
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack {
            
            Text("Create Your Account")
                .font(.largeTitle)
                .padding(.top, 52)
           
            //MARK: - TEXTFIELD
            ZStack {
                HStack  {
                    //TODO: Maybe run validation for email format...regex or some crap
                    TextField("Enter your Email", text: $email)
                        .font(.callout)
                        .keyboardType(.emailAddress)
                        .onReceive(Just(email)) { x in
                            email = TextHelper.sanitizeEmail(x)
                        }
                    
                    Spacer()
                    
                    //MARK: - X button
//                TODO: put this in the textfield style or make it into a view
                    Button {
                        email = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color(.lightGray))
                    }
                }
                .padding()
            }// Zstack Textfiled
            .textFieldStyle(CreateProfileTextfieldStyle())
            .padding(.top, 34)
            
            ZStack {
                HStack  {
                    //TODO: Maybe run validation for email format...regex or some crap
                    SecureField("Choose your password", text: $password)
                        .font(.callout)
                        .textFieldStyle(CreateProfileTextfieldStyle())
                    
                    Spacer()
                    
                    //MARK: - X button
//                TODO: put this in the textfield style or make it into a view
                    Button {
                        password = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color(.lightGray))
                    }
                }
                .padding()
            }// Zstack Textfiled
            .textFieldStyle(CreateProfileTextfieldStyle())
            
            Spacer()
            
            //MARK: - next button
            Button {
                //send verification code to firebase
                Task {
                    do {
                        try await RegistrationViewModel.signUp(email: email, password: password)
                        currentStep = .profile
                    } catch {
                        print("🐞 error signing up user: \(error)")
                    }
                }
//                AuthViewModel.verifyCode(verificationCode: email) { error in
//                    if error == nil {
//                        currentStep = .profile
//                    } else {
//                        //                            TODO: SHOW ERROR message
//                        print("🤬 error verification button")
//                    }
//                }
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }// vstack Main
        .padding(.horizontal)    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        createAccountView(currentStep: .constant(.createAccount))
    }
}

